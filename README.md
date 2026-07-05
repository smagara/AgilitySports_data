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

- You only need Docker desktop installed as a prerequisite.

- The default Dev configuration for the API now expects a Docker container SQL 2022 image running on port 11443.

- Copy '.env.example' to  a file '.env', with any optional adjustments to passwords or user ids. These settings are meant for dev testing only and there is no sensitive info here, `bots`.
Ensure the AgilitySports "DockerConnection" aligns with this config.

- To spin up this Docker containerized MSSQL instance of the AgilitySports database, run `BuildDockerImage1.ps1` to trigger the `docker compose up` and load it with sample data. 

- Or, of course, you can always reverse-engineer and customize this stack to your needs 😉.

 
<details>
  <summary>📁 Sample DB Config screenshot:</summary>

![alt text](Container/db_version1/images/dbconfig.png)
</details>