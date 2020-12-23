
# The WebSite1 Project

This document collects all the information related to the WebSite1 project.

---

## Features of the WebSite1

1. The application serves static content from Azure Blob Storage and implements an API using Azure Functions. 

---

## Reference Architectiures



The Architecture implemented in this project is inspired and based on a combination of the following references. 

- [Serverless web application on Azure](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/serverless/web-app) 

#### More Architecture References

- [Azure Architecture Center](https://docs.microsoft.com/en-us/azure/architecture/)

---

## Entry Points

The following are end points which can be used to test the function apps that make up the site.

- [This is the entry point to the function in HttpTriggerCSharp.cs with the proper Query Parameter 'name' set to the value 'Davide'](https://fa-ntt-fa1ws1.azurewebsites.net/api/HttpTriggerCSharp?code=nBvNmPFahTU3G4FVaOxQFaaF0tN1JmXmGntanewm8fHB18crdoln8A==&name=Davide)

- [This is the entry point to the function in HttpTriggerCSharp.cs without a value for the query parameter 'name'](https://fa-ntt-fa1ws1.azurewebsites.net/api/HttpTriggerCSharp?code=nBvNmPFahTU3G4FVaOxQFaaF0tN1JmXmGntanewm8fHB18crdoln8A==)

---
## Storage Account For Static Content

On any existing **Storage Account Resource** the **Static website** feature available under the **Settings** in the Azure Portal may be manually enabled. The same can be done after the SA has been created and/or deployed either through the portal or via scripts as well.

### Refs

- [Static website hosting in Azure Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)  
- [Host a static website in Azure Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-how-to?tabs=azure-portal#portal-find-url)

The following is the endpoint to the **index.htm** of the static site **notice the reginal code z6** and the token **web** in the URI.

- https://sawebsite120201221.z6.web.core.windows.net/

The same document is accessible at the following URL but in this case there is no reference to the regional code and the **$web** becomes part of the path in the URI to the resource.

- https://sawebsite120201221.blob.core.windows.net/$web/index.html

The former URL is a feature of the **Static Web Site** set-up of the storage account itself. This Azure feature has been enabled on the **sawebsite120201221** Storage Account and provides an endpoint to the index.html of the static site.

The latter is the URL to the blob **index.html** of the **$web** container. This URL may be used to retrieve **index.html** as long as the **access level on the container $web** is set to either **public or blob**. If such level is set back to **private** as it is the case by default then only the former URL can be used to access the **index.htm** resource. 

---

## Azure Function Proxy 

Refs

- [Work with Azure Functions Proxies](https://docs.microsoft.com/en-us/azure/azure-functions/functions-proxies)

---
With this feature, you can specify endpoints on your function app that are implemented by another resource. 

You can use these proxies to 

1. Break a large API into multiple function apps (as in a microservice architecture), while still presenting a single API surface for clients.

2. When a **Storage Account For Static Content** is used in conjuction to a function app it is possible to set up a proxy to a function so that the consumer of the function can invoke it via the URI of the proxy rather than the end point of the function itself. This is further illustrated by the examples below.

In order to set up proxies for some or all the functions in a **Azure Functions App** it is sufficient to use a **proxies.json** file located at the route of the project folder where the **myfunction.csproj** file resides.

---

#### Proxy Example 1

```
{
    "$schema": "http://json.schemastore.org/proxies",
    "proxies": {
        "proxy1": {
            "matchCondition": {
                "methods": [ "GET" ],
                "route": "/"
            },
            "backendUri": "https://sawebsite120201221.z6.web.core.windows.net/"
        }
    }
}
         
```

In the code exerpt above which is taken from the file **proxies.json** a proxy with the **friendly name** _proxy1_ is placed in front of the route address of the function app **"/"**. 


This proxy allows the following mappings.

|Called URI|Proxied to URI|
|:---:|:---:|
|GET https://fa-ntt-fa1ws1.azurewebsites.net/|https://sawebsite120201221.z6.web.core.windows.net/|
|GET http://fa-ntt-fa1ws1.azurewebsites.net/|https://sawebsite120201221.z6.web.core.windows.net/|
|||

<br/><br/>
 
 The address https://sawebsite120201221.z6.web.core.windows.net/ in turn is the base address of a **Storage Account** on which the **Static Content** feature is enabled. This is tuen means that when teh proxy relays from the requested URI to its backend URI the **index.html** document in the **$web** blob container of this storage account is retrieved and returned to the caller. 


#### Proxy Example 2

```
...
"proxy2": {
            "matchCondition": {
                "methods": [ "GET" ],
                "route": "/{*restOfPath}"
            },
            "backendUri": "https://sawebsite120201221.z6.web.core.windows.net/{restOfPath}"
        }
        ...
```

In this example a new proxy element named **proxy2** is added to the collection **"proxies"** in the **proxies.json** document. This new proxy makes use of the **{\*restOfPath}** parameter in the **route** so that any trailing parts of the path following the route address of the function app matches the value of this paramter. This value is then reused in the **backendUri** specification of the proxy to relay to the URI of the resource placed in the **$web** blob container holding the static content.

That is **functionappbaseaddress/test** is going to be prozied to **storageAccountBaseAddress/test.html** and so on.

---

# Powershell Scripts

This solution makes use of a number of powershell scripts designed to illustrate the processes as part of the development lifecycle. These script may be used to 
actually run an iteration of the lifecycle semi automatically. However, their purpose is actually illustrate the steps behind a more comprehensive process of
automation.

In order to run the script successfully set the path of the powershell shell to 
folder where the *.ps1 reside as indicated below. Some of these script use relative
paths to find assets they are concerned with thus they will not work if the powershell shell is not set to have the folder below as its working directory.

```
C:\VSProjects\XSpace\WebSite1
```

- 001_create_resources_ws1
- 002_create_resources_fa1ws1
- 003_deploy_fa1ws1
- 004_sync_contents_to_sa_ws1
- 005_sync_contents_to_sa_ws1_ni

---

## Sync of the Contents Folder

In this inmplementation a **WebSite1/Content** folder is used to hold all the static content of the site.

```
sync_contents_to_sa_ws1.ps1
```

The sctript **sync_contents_to_sa_ws1.ps1** is used to sync the folder on the local PC to the **$web** blob container of the storage account that is used to hold the static content. This script makes use of the freely available **azcopy.exe**. 

The **azcopy.exe** must be present on the system from which the static content is synched. This executable can be simply downloaded and copied over to the target system and does not need to be installed on it. 

For eample it may reside on the target system at the following path and used as it is in the **sync_contents_to_sa_ws1.ps1** or scripts which has similar goal.

```
C:\"Program Files"\AzCopy\azcopy.exe

```

More information is available in the Refs embedded in the script file.

In order to run the script use **ConEmu** and the command below to start a new session of the **Powwrshell** console in **admin** mode and make sure the working directory of the script is ```C:\VSProjects\XSpace\WebSite1```.

```
powershell -new_console:a
```

In the Powershell session it is now possible to invoke the execution of the script directly like below.

```
.\sync_contents_to_sa_ws1.ps1
```

As this particular script makes use of a **interactive authentication** the user who executes it is going to be prompted to enter their credentials on each run and verify their ID through MFA via their Authenitcator application that is installed on theuir phones.

---