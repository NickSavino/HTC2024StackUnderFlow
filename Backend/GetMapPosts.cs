using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Core.Function
{
    public class GetMapPostsFunction
    {
        private readonly ILogger<GetMapPostsFunction> _logger;

        public GetMapPostsFunction(ILogger<GetMapPostsFunction> logger)
        {
            _logger = logger;
        }

        [Function("GetMapPosts")]
        public async Task<HttpResponseData> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", Route = "mapposts")] HttpRequestData req)
        {
            _logger.LogInformation("Processing request to get all MapPosts.");

            // Database connection string from environment variable
            string connectionString = Environment.GetEnvironmentVariable("SqlConnectionString");

            if (string.IsNullOrEmpty(connectionString))
            {
                _logger.LogError("SqlConnectionString environment variable is not set.");
                var errorResponse = req.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
                await errorResponse.WriteStringAsync("Server configuration error. Please contact the administrator.");
                return errorResponse;
            }

            try
            {
                var mapPosts = new List<MapPost>();

                using (var connection = new SqlConnection(connectionString))
                {
                    await connection.OpenAsync();

                    string query = "SELECT Id, Title, Description, Latitude, Longitude, CreatedAt FROM MapPost";
                    using (var command = new SqlCommand(query, connection))
                    {
                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                mapPosts.Add(new MapPost
                                {
                                    Id = reader.GetInt32(0),
                                    Title = reader.GetString(1),
                                    Description = reader.GetString(2),
                                    CreatedAt = reader.GetDateTime(3)
                                });
                            }
                        }
                    }
                }

                var response = req.CreateResponse(System.Net.HttpStatusCode.OK);
                response.Headers.Add("Content-Type", "application/json");

                // Use System.Text.Json to serialize
                string jsonResponse = JsonSerializer.Serialize(mapPosts, new JsonSerializerOptions { WriteIndented = true });
                await response.WriteStringAsync(jsonResponse);

                return response;
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error retrieving MapPosts: {ex.Message}");
                var errorResponse = req.CreateResponse(System.Net.HttpStatusCode.InternalServerError);
                await errorResponse.WriteStringAsync("An error occurred while fetching the data.");
                return errorResponse;
            }
        }

        public class MapPost
        {
            public int Id { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
            public double Latitude { get; set; }
            public double Longitude { get; set; }
            public DateTime CreatedAt { get; set; }
        }
    }
}
