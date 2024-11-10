using System.IO;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using MetadataExtractor;
using MetadataExtractor.Formats.Exif;

namespace Core.Function
{
    public class MetaDataParser
    {
        private readonly ILogger<MetaDataParser> _logger;

        public MetaDataParser(ILogger<MetaDataParser> logger)
        {
            _logger = logger;
        }

        [Function(nameof(MetaDataParser))]
        public async Task Run([BlobTrigger("attachments/{name}", Connection = "AzureWebJobsStorage")] Stream stream, string name)
        {
            _logger.LogInformation($"Processing blob: {name}");

            try
            {
                // Save the blob to a temporary file
                var tempFilePath = Path.GetTempFileName();
                using (var fileStream = File.Create(tempFilePath))
                {
                    await stream.CopyToAsync(fileStream);
                }

                // Extract metadata from the image
                var directories = ImageMetadataReader.ReadMetadata(tempFilePath);

                foreach (var directory in directories)
                {
                    foreach (var tag in directory.Tags)
                    {
                        _logger.LogInformation($"{directory.Name} - {tag.Name} = {tag.Description}");
                    }
                }

                // Extract GPS data
                var gpsDirectory = directories.OfType<GpsDirectory>().FirstOrDefault();
                if (gpsDirectory != null)
                {
                    var location = gpsDirectory.GetGeoLocation();
                    if (location != null)
                    {
                        _logger.LogInformation($"GPS Location: Latitude = {location.Latitude}, Longitude = {location.Longitude}");
                    }
                    else
                    {
                        _logger.LogInformation("No GPS location data found in the image.");
                    }
                }
                else
                {
                    _logger.LogInformation("No GPS directory found in the image metadata.");
                }

                _logger.LogInformation($"Finished processing blob: {name}");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error processing blob {name}: {ex.Message}", ex);
            }
        }
    }
}
