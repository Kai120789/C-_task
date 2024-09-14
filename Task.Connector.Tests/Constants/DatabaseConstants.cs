namespace Task.Connector.Tests.Constants
{
    internal class AccessDatabases
    {
        public const string POSTGRE = "POSTGRE";
    }

    internal static class DatabaseConnectors
    {
        const string CONNECTION_TEMPLATE = "@connection";

        const string POSTGRE_CONFIGURATION = $"ConnectionString='{CONNECTION_TEMPLATE}';Provider='PostgreSQL.9.5';SchemaName='AvanpostIntegrationTestTaskSchema';";

        public const string POSGRE_PROVIDER = "POSTGRE";

        public static string GetPostgresConfiguration(string connectionString)
        {
            return POSTGRE_CONFIGURATION.Replace(CONNECTION_TEMPLATE, connectionString);
        }
    }
}
