
## Build a Docker image on dev-edition of SQL 2022 with enough seed data to get you started.
## You will need Docker Desktop installed as a prerequisite.

param(
	[switch]$ForegroundLogs
)

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
	Write-Host "Docker CLI is not installed or not on PATH." -ForegroundColor Red
	Write-Host "Please install Docker Desktop, then run this script again." -ForegroundColor Yellow
	pause
	exit 1
}

docker info *> $null
if ($LASTEXITCODE -ne 0) {
	Write-Host "Docker appears to be stopped." -ForegroundColor Red
	Write-Host "Please start Docker Desktop (or the Docker daemon), wait until it is running, then rerun this script." -ForegroundColor Yellow
	pause
	exit 1
}

$composeDir = Join-Path $PSScriptRoot "Container\db_Version2"
Push-Location $composeDir

$resolvedHostSqlPort = "21433"
if (-not [string]::IsNullOrWhiteSpace($env:HOST_SQL_PORT)) {
	$resolvedHostSqlPort = $env:HOST_SQL_PORT.Trim()
}
else {
	$envFilePath = Join-Path $composeDir ".env"
	if (Test-Path $envFilePath) {
		$hostPortLine = Get-Content $envFilePath | Where-Object { $_ -match '^\s*HOST_SQL_PORT\s*=' } | Select-Object -First 1
		if ($hostPortLine -and $hostPortLine -match '^\s*HOST_SQL_PORT\s*=\s*([^#\r\n]+)') {
			$candidatePort = $Matches[1].Trim()
			if (-not [string]::IsNullOrWhiteSpace($candidatePort)) {
				$resolvedHostSqlPort = $candidatePort
			}
		}
	}
}

$probeHostPath = Join-Path $composeDir "database"
$probeHostFile = Join-Path $probeHostPath "001-create-database.sql"
if (-not (Test-Path $probeHostFile)) {
	Write-Host "Expected SQL seed file not found: $probeHostFile" -ForegroundColor Red
	Write-Host "Verify the V2 database scripts exist in the compose folder." -ForegroundColor Yellow
	Pop-Location
	pause
	exit 1
}

Write-Host "Resetting dev SQL stack (containers + volumes)..." -ForegroundColor Green
docker compose down -v --remove-orphans
if ($LASTEXITCODE -ne 0) {
	Write-Host "Failed to reset existing Docker compose resources." -ForegroundColor Red
	Pop-Location
	pause
	exit 1
}

Write-Host "Starting sqlserver container..." -ForegroundColor Green
docker compose up -d sqlserver
if ($LASTEXITCODE -ne 0) {
	Write-Host "Failed to start sqlserver container." -ForegroundColor Red
	Pop-Location
	pause
	exit 1
}

Write-Host "Running one-time database init and seed job..." -ForegroundColor Green
$maxAttempts = 3
$seedSucceeded = $false
for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
	if ($attempt -gt 1) {
		Write-Host "Retrying init/seed ($attempt of $maxAttempts)..." -ForegroundColor Yellow
		Write-Host "Resetting stack before retry..." -ForegroundColor Cyan
		docker compose down -v --remove-orphans
		if ($LASTEXITCODE -ne 0) {
			Write-Host "Failed to reset Docker compose resources before retry." -ForegroundColor Red
			break
		}

		Write-Host "Restarting sqlserver before retry..." -ForegroundColor Green
		docker compose up -d sqlserver
		if ($LASTEXITCODE -ne 0) {
			Write-Host "Failed to restart sqlserver before retry." -ForegroundColor Red
			break
		}
	}
	docker compose up init-db-image
	$initContainerId = (docker compose ps -a -q init-db-image | Select-Object -First 1).Trim()
	$initExitCode = $null
	if (-not [string]::IsNullOrWhiteSpace($initContainerId)) {
		$initExitCode = (docker inspect --format='{{.State.ExitCode}}' $initContainerId | Select-Object -First 1).Trim()
	}

	if ($initExitCode -eq "0") {
		$seedSucceeded = $true
		break
	}

	Write-Host "Init attempt failed (initExit=$initExitCode)." -ForegroundColor Yellow
}

if (-not $seedSucceeded) {
	Write-Host "Database init/seed failed after $maxAttempts attempts." -ForegroundColor Red
	Write-Host "Run '.\DockerLogViewer.ps1' from repo root for detailed logs." -ForegroundColor Yellow
	Pop-Location
	pause
	exit 1
}

Write-Host "Ensuring sqlserver stays available for developers..." -ForegroundColor Cyan
docker compose up -d sqlserver
if ($LASTEXITCODE -ne 0) {
	Write-Host "Seed succeeded, but failed to keep sqlserver running." -ForegroundColor Yellow
	Pop-Location
	pause
	exit 1
}

Write-Host "Database is ready for development on localhost,$resolvedHostSqlPort." -ForegroundColor Green
if ($ForegroundLogs) {
	Write-Host "Following sqlserver logs (Ctrl+C to stop viewing logs)..." -ForegroundColor DarkGray
	docker compose logs -f sqlserver
}
else {
	Write-Host "Use 'docker compose -f .\Container\db_version2\docker-compose.yml logs -f sqlserver' to view SQL logs when needed." -ForegroundColor DarkGray
}

Pop-Location

pause