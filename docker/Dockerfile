# Rocky Linuxの最新を指定
FROM alpine:latest

ARG MT_FILE="local"
RUN echo ${MT_FILE}
MAINTAINER "redamoon"
USER root
RUN apk update && apk upgrade
RUN apk add apache2

# ===========================
# Perl Tools
# ===========================
RUN apk add --no-cache perl perl-cgi
RUN apk add --no-cache perl-app-cpanminus

## ===========================
## Locale Setting
## ===========================
#RUN cd ~/ \
#  && dnf -y install langpacks-ja \
#  && localectl set-locale LANG=ja_JP.UTF-8; exit 0
#
# ===========================
# Base Package
# ===========================
RUN apk add --no-cache git unzip

# ===========================
# Perl・DB・Dnfリポジトリ・CAPN
# ===========================
RUN apk add --no-cache perl-module-install perl-dbd-mysql

# ===========================
# 必須モジュール
# ===========================
RUN apk add --no-cache 	imagemagick-perlmagick perl-digest-md5 perl-mozilla-ca perl-html-parser
#
## ===========================
## Memcached
## ===========================
#RUN dnf -y install memcached "perl(Cache::Memcached)"
#
## ===========================
## SMTP認証関連ライブラリー
## ===========================
#RUN dnf -y install "perl(IO::Socket::SSL)" "perl(Net::SSLeay)" "perl(Net::SMTP::SSL)"
#RUN dnf -y install "perl(Digest::HMAC)"
#
#RUN dnf -y install "perl(IO::Socket::SSL)" "perl(Net::SSLeay)" "perl(Net::SMTP::SSL)"
#RUN cpan Net::SMTP::TLS
#RUN dnf -y install "perl(Digest::HMAC)"
#RUN cpan Net::SMTP::TLS
#
## ===========================
## Other：バックアップ
## ===========================
#RUN dnf -y install "perl(Archive::Zip)" "perl(Archive::Tar)" "perl(XML::LibXML::SAX)"
#RUN dnf -y install expat-devel "perl(ExtUtils::MakeMaker)" "perl(Test::Simple)" "perl(XML::Parser)"
#RUN dnf -y install "perl(Archive::Zip)" "perl(Archive::Tar)" "perl(XML::LibXML::SAX)"
#RUN cpan XML::SAX::Expat
#
## ===========================
## Other：PSGI
## ===========================
#RUN dnf -y install --skip-broken "perl(CGI::Parse::PSGI)" "perl(Plack)"
#RUN dnf -y install --skip-broken "perl(CGI)"
#RUN dnf -y install --skip-broken "perl(SOAP::Transport::HTTP)" "perl(XMLRPC::Transport::HTTP)"
##RUN cpan Devel::StackTrace CGI::Parse::PSGI Plack CGI
##RUN cpan SOAP::Transport::HTTP XMLRPC::Transport::HTTP #cpanだと時間がかかりすぎてタイムアウトする
#
## ===========================
## Other：ライブラリ
## ===========================
#RUN dnf -y install --skip-broken "perl(Authen::SASL)" "perl(Crypt::SSLeay)" "perl(Crypt::DSA)" "perl(Digest::SHA)" "perl(Digest::SHA1)" "perl(HTML::Parser)" "perl(XML::Parser)"
#RUN dnf -y install --skip-broken "perl(Heap::Fibonacci)" "perl(File::NFSLock)" "perl(IO::String)" "perl(DB_File)" "perl(HTTP::Date)" "perl(Text::CSV_XS)" "perl(MIME::Parser)" "perl(LWP::UserAgent)" "perl(Scalar::Util)" "perl(CGI::Cookie)" "perl(File::Spec)" "perl(parent)"
#
## ===========================
## php
## ===========================
##RUN dnf -y install --enablerepo=remi,remi-php82 php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-mysqlnd && \
##    dnf clean all && \
##    sed -i -e "s/;date.timezone *=.*$/date.timezone = Asia\/Tokyo/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.language *=.*$/mbstring.language = Japanese/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.internal_encoding *=.*$/mbstring.internal_encoding = UTF-8/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.http_input *=.*$/mbstring.http_input = UTF-8/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.http_output *=.*$/mbstring.http_output = pass/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.encoding_translation *=.*$/mbstring.encoding_translation = On/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.detect_order *=.*$/mbstring.detect_order = pass/" /etc/php.ini && \
##    sed -i -e "s/;mbstring.substitute_charset *=.*$/mbstring.substitute_charset = none/" /etc/php.ini
#
# ===========================
# Httpd Setting
# ===========================
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf
RUN sed -i '$a\LoadModule cgi_module modules/mod_cgi.so' /etc/apache2/httpd.conf
RUN sed -i.org '/#AddHandler cgi-script/s/#//' /etc/apache2/httpd.conf
RUN sed -i    "/^#NameVirtualHost \*:80$/ s/#NameVirtualHost \*:80/NameVirtualHost \*:80/" /etc/apache2/httpd.conf
RUN sed -i -e "s/KeepAlive Off/KeepAlive On/g" /etc/apache2/httpd.conf
RUN sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/apache2/httpd.conf
RUN sed -i -e "s/DirectoryIndex index.html index.html.var/DirectoryIndex index.html index.php/g" /etc/apache2/httpd.conf
RUN sed -i '$a\LoadModule include_module modules/mod_include.so' /etc/apache2/httpd.conf
RUN sed -i '$a\LoadModule filter_module modules/mod_filter.so' /etc/apache2/httpd.conf
RUN echo 'AddHandler cgi-script .cgi' >> /etc/apache2/httpd.conf
RUN echo '<Directory "/var/www/local/cgi-bin">' >> /etc/apache2/httpd.conf
RUN echo '    AllowOverride None' >> /etc/apache2/httpd.conf
RUN echo '    Options +ExecCGI' >> /etc/apache2/httpd.conf
RUN echo '    Require all granted' >> /etc/apache2/httpd.conf
RUN echo '</Directory>' >> /etc/apache2/httpd.conf

# ===========================
# Movable Type Setting
# ===========================
RUN mkdir -p /var/www/local/html
RUN mkdir -p /var/www/local/cgi-bin
ADD mt-data/${MT_FILE}.zip /var/www/local/cgi-bin/
RUN unzip /var/www/local/cgi-bin/${MT_FILE}.zip -d '/var/www/local/cgi-bin/'
RUN mv /var/www/local/cgi-bin/${MT_FILE} /var/www/local/cgi-bin/mt
RUN chmod o+r /var/www/local/html
RUN chown -R apache:apache /var/www/local/html
RUN chown -R apache:apache /var/www/local/cgi-bin/mt
RUN chmod 777 /var/www/
RUN chmod 777 /var/www/local
RUN chmod 777 /var/www/local/html
RUN chmod 755 /var/www/local/cgi-bin/mt/*.cgi
RUN echo '<Directory "/var/www/local/cgi-bin">' >> /etc/apache2/httpd.conf
RUN echo '    AllowOverride All' >> /etc/apache2/httpd.conf
RUN echo '    Options +ExecCGI' >> /etc/apache2/httpd.conf
RUN echo '    Require all granted' >> /etc/apache2/httpd.conf
RUN echo '</Directory>' >> /etc/apache2/httpd.conf

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
