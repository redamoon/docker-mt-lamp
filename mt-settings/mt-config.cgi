# The CGIPath is the URL to your Movable Type directory
CGIPath http://localhost:8085/mt/

# simply remove it or comment out the line by prepending a "#".
StaticWebPath /mt-static/
StaticFilePath /var/www/html/mt-static
BaseSitePath   /var/www/html
#================ DATABASE SETTINGS ==================
#   CHANGE setting below that refer to databases
#   you will be using.

##### MYSQL #####
DBSocket /var/lib/mysql/mysql.sock
ObjectDriver DBI::mysql
Database movabletype
DBUser movabletype
DBPassword movabletype
DBHost mysql

## Change setting to language that you want to using.
DefaultLanguage ja

## Debug Mode
DebugMode 1

PIDFilePath /var/run/mt.pid
