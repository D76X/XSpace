
# The WebSite1 Project

This document collects all the information related to the WebSite1 project.

---

## Features of the WebSite1

1. The application serves static content from Azure Blob Storage, and implements an API using Azure Functions. 

---

## Reference Architectiures



The Architecture implemented in this project is inspired and based on a combination of the following references. 

- [Serverless web application on Azure](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/serverless/web-app) 

#### More Architecture References

- [Azure Architecture Center](https://docs.microsoft.com/en-us/azure/architecture/)

---

## Entry Points

The following are end points which can be used to test the function apps that make up the site.

- [This is the entry point to the function in HttpTriggerCSharp.cs with the proper Query Parameter 'name' set to the value 'Davide'](https://fa-ntt-fa1ws1.azurewebsites.net/api/HttpTriggerCSharp?code=sM4PUqS92Vj0XcHFa0PtTlOwdx1o7CEd5mc5poh581njHbYcF3M%2Fhw%3D%3D&name=Davide)

- [This is the entry point to the function in HttpTriggerCSharp.cs without a value for the query parameter 'name'](https://fa-ntt-fa1ws1.azurewebsites.net/api/HttpTriggerCSharp?code=sM4PUqS92Vj0XcHFa0PtTlOwdx1o7CEd5mc5poh581njHbYcF3M%2Fhw%3D%3D)

---
## Storage Account For Static Content

On any existing **Storage Account Resource** the **Static website** feature available under the **Settings** in the Azure Portal may be manually enabled. The same can be done after the SA has been created and/or deployed either through the portal or via scripts as well.

### Refs

- [Static website hosting in Azure Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)  
- [Host a static website in Azure Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-how-to?tabs=azure-portal#portal-find-url)

The following is the endpoint to the **index.htm** of the static site **notice the reginal code z6** and the token **web** in the URI.

- https://sawebsite120200103.z6.web.core.windows.net/

The same document is accessible at the following URL but in this case there is no reference to the regional code and the **$web** becomes part of the path in the URI to the resource.

- https://sawebsite120200103.blob.core.windows.net/$web/index.html

The former URL is a feature of the **Static Web Site** set-up of the storage account itself. This Azure feature has been enabled on the **sawebsite120200103** Storage Account and provides an endpoint to the index.html of the static site.

The latter is the URL to the blob **index.html** of the **$web** container. This URL may be used to retrieve **index.html** as long as the **access level on the container $web** is set to either **public or blob**. If such level is set back to **private** as it is the case by default then only the former URL can be used to access the **index.htm** resource. 

---

## Azure Function Proxy 

Refs

- [Work with Azure Functions Proxies](https://docs.microsoft.com/en-us/azure/azure-functions/functions-proxies)

---
With this feature, you can specify endpoints on your function app that are implemented by another resource. 

You can use these proxies to 

1. Break a large API into multiple function apps (as in a microservice architecture), while still presenting a single API surface for clients.

2. When a **Storage Account For Static Content** is used in conjuction to a function app it is...

Static content for the site is stored in **a Storage Account** and it is served to clients via Proxied Azure Functions this... 

---



---