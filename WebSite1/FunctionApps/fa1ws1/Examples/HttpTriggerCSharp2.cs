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
    public static class HttpTriggerCSharp2
    {
        [FunctionName("HttpTriggerCSharp2")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function 2");

            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            log.LogInformation("C# HTTP trigger function 2 processed a request.");
            return name != null
                ? (ActionResult)new OkObjectResult($"Hello, {name} from Function 2")
                : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
        }
    }
}
