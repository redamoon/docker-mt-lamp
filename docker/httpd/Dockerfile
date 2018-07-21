# CentOSの最新を指定
FROM centos:latest
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
RUN yum -y install epel-release
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
RUN yum -y install "perl(Heap::Fibonacci)" "perl(File::NFSLock)" "perl(IO::String)" "perl(DB_File)"

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
ADD mt-settings/mt-data/MT-7.0.zip /var/www/local/cgi-bin/
RUN unzip '/var/www/local/cgi-bin/MT-7.0.zip' -d '/var/www/local/cgi-bin/'
RUN mv /var/www/local/cgi-bin/MT-7.0 /var/www/local/cgi-bin/mt
#RUN sed -i s/DATABASE_NAME/'"${MT_DATABASE_NAME}"'/ /var/www/local/cgi-bin/mt/mt-config.cgi-original
ADD mt-settings/plugins /var/www/local/cgi-bin/mt/plugins/
ADD mt-settings/mt-static/plugins /var/www/local/cgi-bin/mt/mt-static/plugins/
RUN chown -R apache:apache /var/www/local/cgi-bin/mt
RUN chmod 755 /var/www/local/cgi-bin/mt/*.cgi

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
