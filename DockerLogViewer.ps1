param(
	[string]$ContainerName,
	[string]$ComposeFile = "Container/db_version1/docker-compose.yml",
	[string]$Service = "init-db-image",
	[switch]$Follow,
	[int]$Tail = 200
)

$composePath = Join-Path $PSScriptRoot $ComposeFile
if (-not (Test-Path $composePath)) {
	Write-Error "Compose file not found at '$composePath'. Provide -ComposeFile with a valid path."
	exit 1
}

if ([string]::IsNullOrWhiteSpace($ContainerName)) {
	$containerId = docker compose -f $composePath ps -a -q $Service
	if ([string]::IsNullOrWhiteSpace($containerId)) {
		Write-Error "No container found for service '$Service' in '$composePath'. Start it first with: docker compose -f `"$composePath`" up -d sqlserver; docker compose -f `"$composePath`" up $Service"
		exit 1
	}
	$ContainerName = (docker ps -a --filter "id=$containerId" --format "{{.Names}}" | Select-Object -First 1)
}

$containerExists = docker ps -a --format "{{.Names}}" | Select-String -SimpleMatch -Pattern $ContainerName
if (-not $containerExists) {
	Write-Error "Container '$ContainerName' was not found. Run 'docker ps -a' to list available containers."
	exit 1
}

$logPath = docker inspect --format='{{.LogPath}}' $ContainerName
Write-Host "Docker engine log path (inside Linux VM/container host):"
Write-Host $logPath
Write-Host ""
Write-Host "Streaming logs through Docker API (works from Windows PowerShell):"

if ($Follow) {
	docker logs -f --tail $Tail $ContainerName
}
else {
	docker logs --tail $Tail $ContainerName
}