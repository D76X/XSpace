using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace fa1ws1
{
    public static class GetMetadata
    {
        [FunctionName("GetMetadata")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger GetMetadata");
            // do something here!
            log.LogInformation("C# HTTP trigger GetMetadata processed the request.");
            
            //return new OkObjectResult("C# HTTP trigger GetMetadata returned value!");
            return new JsonResult(new Metadata(){ Type="type",Name="name",Value="value"}); 
        }
    }

    // post input
    public class SearchQuery
    {
        public string Type { get; set; }
        public string Name { get; set; }
        public string Value { get; set; }
    }

    // output
    public class Metadata
    {
        public string Type { get; set; }
        public string Name { get; set; }
        public string Value { get; set; }
    }
}


