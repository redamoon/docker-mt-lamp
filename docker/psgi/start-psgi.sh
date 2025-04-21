export MT_HOME=/var/www/local/cgi-bin/mt
export PERL5LIB=$MT_HOME/lib:$MT_HOME/extlib:$PERL5LIB
cd $MT_HOME
starman --port 5002 --workers 2 mt.psgi
