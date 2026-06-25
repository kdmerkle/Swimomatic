using System.Reflection;
using DbUp;

namespace AthletePlatformAPI.Infrastructure.Migrations;

public static class DatabaseMigrator
{
    public static void MigrateDatabase(string connectionString)
    {
        try
        {
            Console.WriteLine($"Attempting database migration with connection string: {connectionString.Substring(0, Math.Min(50, connectionString.Length))}...");
            
            // First, debug what resource names are present
            var assembly = Assembly.GetExecutingAssembly();
            var resourceNames = assembly.GetManifestResourceNames()
                .Where(s => s.StartsWith("AthletePlatformAPI.db.migrations"))
                .OrderBy(s => s)
                .ToList();
            
            Console.WriteLine($"Found {resourceNames.Count} migration resources:");
            foreach (var name in resourceNames)
            {
                Console.WriteLine($"- {name}");
            }

            var upgrader = DeployChanges.To
                .SqlDatabase(connectionString)
                .WithScriptsEmbeddedInAssembly(
                    assembly,
                    s => s.StartsWith("AthletePlatformAPI.db.migrations"))
                .WithTransaction()
                .LogToConsole()
                .Build();

            Console.WriteLine("Starting database upgrade...");
            var result = upgrader.PerformUpgrade();
            
            if (!result.Successful)
            {
                Console.WriteLine($"DbUp migration failed!");
                Console.WriteLine($"Error Message: {result.Error?.Message}");
                if (result.Error?.InnerException != null)
                {
                    Console.WriteLine($"Inner Exception: {result.Error.InnerException?.Message}");
                    Console.WriteLine($"Inner Exception StackTrace: {result.Error.InnerException?.StackTrace}");
                }
                throw new Exception($"DbUp migration failed: {result.Error!.Message}", result.Error);
            }
            else
            {
                Console.WriteLine("Database migration completed successfully!");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Migration exception caught: {ex.Message}");
            Console.WriteLine($"Stack trace: {ex.StackTrace}");
            throw;
        }
    }
}
