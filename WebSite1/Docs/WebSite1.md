
# The WebSite1 Project

This document collects all the information related to the WebSite1 project.

The architecture of 

---
## Storage Account For Static Content

### Refs
- https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website
- https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-how-to?tabs=azure-portal#portal-find-url

The following is the endpoint to the **index.htm** of the static site **notice the reginal code z6**.

- https://sawebsite120200103.z6.web.core.windows.net/

The same document is accessible at the following URL.

- https://sawebsite120200103.blob.core.windows.net/$web/index.html

The former URL is a feature of the Static Web Site set-up of the storage account itself. This Azure feature has been enabled on the **sawebsite120200103** Storage Account and provides an endpoint to the index.html of the static site.

The latter is the URL to the blob **index.html** of the **$web** container. This URL amy be used to retrieve **index.html** as long as the **access level on the container $web** is set to either **public or blob**. If such level is set back to **private** as it is the case per default then only the former URL can be used to access the **index.htm** resource. 

---

## Azure Function Proxy 

Static content stored in the **seb-site enabled Storage Account** is served to clients via Proxied Azure Functions.

Refs

-- https://docs.microsoft.com/en-us/azure/azure-functions/functions-proxies

---