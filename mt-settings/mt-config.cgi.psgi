# The CGIPath is the URL to your Movable Type directory
CGIPath http://localhost:5002/

# simply remove it or comment out the line by prepending a "#".
StaticWebPath http://localhost:5002/mt-static

#================ DATABASE SETTINGS ==================
#   CHANGE setting below that refer to databases
#   you will be using.

##### MYSQL #####
ObjectDriver DBI::mysql
Database movabletype
DBUser movabletype
DBPassword movabletype
DBHost mysql

## Change setting to language that you want to using.
DefaultLanguage ja

## Debug Mode
DebugMode 1

## PSGI specific settings
PSGIStreaming 1
PSGIServeStatic 1
