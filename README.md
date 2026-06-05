# This repo is from the Full-Stack hands-on lab presented at the PhillyDotNet users group by Bill Wolff

## The assignment is to create an Angular sports website with a DotNet Minimal API layer and a SQL Server backend database

---

A replay of the hands-on demonstration can be found on YouTube [here](https://github.com/phillydotnet/Presentations/tree/main/2023/0816-dotnet).

My copy of the code has evolved since that original training and is maintained on GitHub:

- Angular Web frontend repo (TypeScript) is [here](https://github.com/smagara/AgilitySports_web).
- DotNet Minimal API repo (C#) is [here](https://github.com/smagara/AgilitySports_api).
- SQL Server Database code is [here](https://github.com/smagara/AgilitySports_data).

See the GitHub project tracking for the various training issues and initiatives [here](https://github.com/users/smagara/projects/3/views/1).  As an exercise in GitHub Project management functionality with KanBan.

CI/CD pipelines are set up to deploy the code to the Azure cloud.

Note for Devs: <br/>
- A prior SQL Server installation is no longer required!
- The default Dev configuration for the API now expects a Docker container SQL 2022 image running on port 11443.
<br/>
- Prior to launching the AgilitySports API, be sure to start the this container with the Powershell script `BuildDockerImage1.ps1` to trigger the required `docker compose up`. This will spin up a SQL instance on this port with some test data to get you started.
	Run from the repository root in PowerShell:
	```powershell
	Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
	.\BuildDockerImage1.ps1
	```
	This starts containers in detached mode to reduce SQL startup log chatter.
	If you need full live logs in the terminal:
	```powershell
	.\BuildDockerImage1.ps1 -ForegroundLogs
	```
	Stop containers when finished:
	```powershell
	docker compose -f .\Container\db_version1\docker-compose.yml down
	```
<br/>
- You only need Docker desktop installed (or at least the daemon) as a prerequisite.
<br/>
- Or, of course, you can always reverse-engineer and customize this stack to your needs 😉.