# Entity Framework Core

| Command      | Results             |
| ------------ | ------------------- |
| `dotnet ef -h` | ask for help.|
| `dotnet ef migrations -h` | ask for help.|
| `dotnet ef migrations remove -h` | ask for help.|
| `dotnet ef database update -h` |.|
| `dotnet ef  migrations add CreateDatabase` |.|
| `dotnet ef migrations add initial` |.|
| `dotnet ef migrations add initial -Force` | Override the migration.|
| `dotnet ef migrations remove` | Remobves the last migration.|
| `dotnet ef database update -TargetMigration "NameOfPreviousMigration"` |.|
| `` |.|
| `` |.|
| `` |.|
| `` |.|

---

### EF Core Tutorials

[Getting Started With Entity Framework Core - Console](https://www.learnentityframeworkcore.com/walkthroughs/console-application)

---

### EF Core References

[Entity Framework Core tools reference - .NET CLI](https://docs.microsoft.com/en-us/ef/core/miscellaneous/cli/dotnet)

--- 

### EF Core Basic set-up

```
dotnet new console        
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Tools 
dotnet add package Microsoft.EntityFrameworkCore.Design
```

---

### EF Core - setting a PK as identity 
[The Fluent API ValueGeneratedOnAdd Method](https://www.learnentityframeworkcore.com/configuration/fluent-api/valuegeneratedonadd-method)

### EF Core Managing Migrations

[Delete or override a migration](https://stackoverflow.com/questions/33231930/is-it-necessary-to-delete-last-migration-and-then-add-migration-with-same-name)

* If you haven't used Update-Database you can just delete it. 

* If you've run the update then roll it back using 

From the PowerShell console

```
Update-Database -TargetMigration "NameOfPreviousMigration", then delete it.
```

Or from a Command Line Window

```
dotnet ef database update
```

---

## EF Core - setting up enities relationships

[Configuring One To Many Relationships in Entity Framework Core](https://www.learnentityframeworkcore.com/configuration/one-to-many-relationship-configuration)  


---

## EF Core Logging

In EF6 the looger was backed into EF but with EF Core it is necessary to set up a provider that is 
an implementation of *ILoggerProvider*. The most readly available implementation of this provider 
is in *.Net Core* and in order to use it from EF Core it is only required to configure EF Core to 
let it know that it has to use the .Net Core provider.

[Logging](https://docs.microsoft.com/en-us/ef/core/miscellaneous/logging)

EF Core logging currently requires an ILoggerFactory which is itself configured with one or more ILoggerProvider. 
Common providers are shipped in the following packages:

* Microsoft.Extensions.Logging.Console: A simple console logger.
* Microsoft.Extensions.Logging.AzureAppServices: Supports Azure App Services 'Diagnostics logs' and 'Log stream' features.
* Microsoft.Extensions.Logging.Debug: Logs to a debugger monitor using System.Diagnostics.Debug.WriteLine().
* Microsoft.Extensions.Logging.EventLog: Logs to Windows Event Log.
* Microsoft.Extensions.Logging.EventSource: Supports EventSource/EventListener.
* Microsoft.Extensions.Logging.TraceSource: Logs to a trace listener using System.Diagnostics.TraceSource.TraceEvent().

```
dotnet add package Microsoft.Extensions.Logging.Console
```

### [Disable Sensitive Logging](https://stackoverflow.com/questions/44202478/lost-parameter-value-during-sql-trace-in-ef-core/44207235) 

In order to allow EF Core 2 to send the values of the parameters used in the compiled SQL to the log output i.e. Console or file. 

```
optionsBuilder.EnableSensitiveDataLogging();
```

---

[Raw SQL Statemnets](https://www.learnentityframeworkcore.com/raw-sql)  

```
var books = context.Books.FromSql("SELECT BookId, Title, AuthorId, Isbn FROM Books").ToList();
```

---

## Multiple DbContext 

### On the same database

https://app.pluralsight.com/player?course=efarchitecture&author=julie-lerman&name=efarchitecture-m2-boundedcontext&clip=6&mode=live  

### Customise the Migration History Table
https://www.bricelam.net/2017/01/04/efcore-history-table.html  
https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/history-table  

### One DB for each DbContext

Keep in mind that the shell is case sensitive that is for example -Context is not the same as -context. The former is not recognised 
while the latter is.

```
dotnet ef migrations add --help

dotnet ef migrations add RideAlongFeedback_RideAlongDate --context RideAlongFeedbackContext

dotnet ef migrations script 0 calendar_0 --context CalendarContext

dotnet ef database update --context CalendarContext
```
---

https://github.com/aspnet/EntityFrameworkCore/issues/5096

```
dotnet ef migrations script --idempotent --output "script.sql" --context MyDbContext
```

