using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Core.Function
{
    public class HttpTriggerTest
    {
        private readonly ILogger<HttpTriggerTest> _logger;

        public HttpTriggerTest(ILogger<HttpTriggerTest> logger)
        {
            _logger = logger;
        }

        [Function("HttpTriggerTest")]
        public IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");
            return new OkObjectResult("Welcome to Azure Functions!");
        }
    }
}
