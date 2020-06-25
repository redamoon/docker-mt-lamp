# CentOSの最新を指定
# FROM centos:latest
# CentOS 7 固定指定
FROM centos:7
MAINTAINER "redamoon"

RUN yum -y clean all

RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7
RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

RUN yum -y update && yum clean all

# ===========================
# Locale Setting
# ===========================
RUN rm -f /etc/rpm/macros.image-language-conf && \
    sed -i '/^override_install_langs=/d' /etc/yum.conf && \
    yum -y reinstall glibc-common && \
    yum clean all

ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

# ===========================
# Base Package
# ===========================
RUN yum -y install git unzip glibc httpd httpd-devel

# ===========================
# Remi リポジトリの追加
# ===========================
RUN yum -y install epel-release
RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# ===========================
# Perl・DB・Yumリポジトリ・CAPN
# ===========================
RUN yum -y install perl perl-CGI perl-CPAN "perl(Module::Build)" "perl(DBD::mysql)"

# ===========================
# 必須モジュール
# ===========================
RUN yum -y install "perl(Image::Magick)" "perl(Digest::MD5)" "perl(Mozilla::CA)" "perl(HTML::Entities)"

# ===========================
# Memcached
# ===========================
RUN yum -y install memcached "perl(Cache::Memcached)"

# ===========================
# SMTP認証関連ライブラリー
# ===========================
RUN yum -y install "perl(IO::Socket::SSL)" "perl(Net::SSLeay)" "perl(Net::SMTP::SSL)" "perl(Net::SMTP::TLS)"
RUN yum -y install "perl(Digest::HMAC)"

# ===========================
# Other：バックアップ
# ===========================
RUN yum -y install "perl(Archive::Zip)" "perl(Archive::Tar)" "perl(XML::LibXML::SAX)" "perl(XML::SAX::Expat)"
RUN yum -y install expat-devel "perl(ExtUtils::MakeMaker)" "perl(Test::Simple)" "perl(XML::Parser)"

# ===========================
# Other：PSGI
# ===========================
RUN yum -y install "perl(CGI::Parse::PSGI)" "perl(Plack)"
RUN yum -y install "perl(CGI)"
RUN yum -y  install "perl(SOAP::Transport::HTTP)" "perl(XMLRPC::Transport::HTTP)"

# ===========================
# Other：ライブラリ
# ===========================
RUN yum -y install "perl(Authen::SASL)" "perl(Crypt::SSLeay)" "perl(Crypt::DSA)" "perl(Digest::SHA)" "perl(Digest::SHA1)" "perl(HTML::Parser)" "perl(XML::Parser)" "perl(YAML::Syck)"
RUN yum -y install "perl(Heap::Fibonacci)" "perl(File::NFSLock)" "perl(IO::String)" "perl(DB_File)" "perl(HTTP::Date)" "perl(Text::CSV_XS)" "perl(MIME::Parser)" "perl(LWP::UserAgent)" "perl(Scalar::Util)" "perl(CGI::Cookie)" "perl(File::Spec)" "perl(parent)"

# ===========================
# php
# ===========================
RUN yum -y install --enablerepo=remi,remi-php72 php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-mysqlnd && \
    yum clean all && \
    sed -i -e "s/;date.timezone *=.*$/date.timezone = Asia\/Tokyo/" /etc/php.ini && \
    sed -i -e "s/;mbstring.language *=.*$/mbstring.language = Japanese/" /etc/php.ini && \
    sed -i -e "s/;mbstring.internal_encoding *=.*$/mbstring.internal_encoding = UTF-8/" /etc/php.ini && \
    sed -i -e "s/;mbstring.http_input *=.*$/mbstring.http_input = UTF-8/" /etc/php.ini && \
    sed -i -e "s/;mbstring.http_output *=.*$/mbstring.http_output = pass/" /etc/php.ini && \
    sed -i -e "s/;mbstring.encoding_translation *=.*$/mbstring.encoding_translation = On/" /etc/php.ini && \
    sed -i -e "s/;mbstring.detect_order *=.*$/mbstring.detect_order = pass/" /etc/php.ini && \
    sed -i -e "s/;mbstring.substitute_charset *=.*$/mbstring.substitute_charset = none/" /etc/php.ini

# ===========================
# Httpd Setting
# ===========================
RUN sed -i.org '/#AddHandler cgi-script/s/#//' /etc/httpd/conf/httpd.conf
RUN sed -i    "/^#NameVirtualHost \*:80$/ s/#NameVirtualHost \*:80/NameVirtualHost \*:80/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/KeepAlive Off/KeepAlive On/g" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/DirectoryIndex index.html index.html.var/DirectoryIndex index.html index.php/g" /etc/httpd/conf/httpd.conf
RUN sed -i '$a\LoadModule include_module modules/mod_include.so' /etc/httpd/conf/httpd.conf
RUN sed -i '$a\LoadModule filter_module modules/mod_filter.so' /etc/httpd/conf/httpd.conf
RUN mkdir -p /var/www/local/cgi-bin

# ===========================
# Movable Type Setting
# ===========================
ADD mt-data/MT-7.0.zip /var/www/local/cgi-bin/
RUN unzip '/var/www/local/cgi-bin/MT-7.0.zip' -d '/var/www/local/cgi-bin/'
RUN mv /var/www/local/cgi-bin/MT-7.0 /var/www/local/cgi-bin/mt
RUN chown -R apache:apache /var/www/local/cgi-bin/mt
RUN chmod 777 /var/www/
RUN chmod 777 /var/www/local
RUN chmod 755 /var/www/local/cgi-bin/mt/*.cgi

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
