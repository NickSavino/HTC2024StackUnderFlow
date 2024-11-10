using System.IO;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Core.Function
{
    public class MetaDetaParser
    {
        private readonly ILogger<MetaDetaParser> _logger;

        public MetaDetaParser(ILogger<MetaDetaParser> logger)
        {
            _logger = logger;
        }

        [Function(nameof(MetaDetaParser))]
        public async Task Run([BlobTrigger("attachments/{name}", Connection = "AzureWebJobsStorage")] Stream stream, string name)
        {
            using var blobStreamReader = new StreamReader(stream);
            var content = await blobStreamReader.ReadToEndAsync();
            _logger.LogInformation($"C# Blob trigger function Processed blob\n Name: {name} \n Data: {content}");
        }
    }
}
