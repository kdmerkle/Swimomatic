-- Note: This script must be run by an admin after the Azure SQL database is provisioned.
-- The managed identity user name matches the App Service name.
-- CREATE USER [athleteplatform-api] FROM EXTERNAL PROVIDER;
-- ALTER ROLE db_datareader ADD MEMBER [athleteplatform-api];
-- ALTER ROLE db_datawriter ADD MEMBER [athleteplatform-api];
-- ALTER ROLE db_ddladmin ADD MEMBER [athleteplatform-api];
-- This is a template/documentation script; actual execution requires Azure AD + SQL Server context.
PRINT 'Managed Identity user setup: run manually via Azure Portal Query Editor or sqlcmd with AAD auth.';
