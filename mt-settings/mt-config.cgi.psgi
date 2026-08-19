# The CGIPath is the URL to your Movable Type directory
# HTTP（.env の WEB_PORT。sample は 10000）。HTTPS で CSS を揃えるなら https://localhost:10443 に変える。
CGIPath https://localhost:10443/cgi-bin/mt/

# simply remove it or comment out the line by prepending a "#".
StaticWebPath https://localhost:10443/cgi-bin/mt/mt-static

# Host-mounted development plugins (see docker-compose.yml).
# Core plugins stay in /var/www/local/cgi-bin/mt/plugins from the MT zip.
PluginPath /var/www/local/mt-dev-plugins

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

## PSGI（静的ファイルは Apache。Starman は動的リクエスト）
PSGIStreaming 1
PSGIServeStatic 0
