# Rocky Linux 9指定
FROM rockylinux:9

RUN echo /etc/redhat-release
ARG MT_FILE="local"
RUN echo ${MT_FILE}
MAINTAINER "redamoon"
USER root
RUN dnf -y clean all

RUN dnf update -y \
    && dnf install -y git unzip glibc httpd httpd-devel \
    && dnf clean all

# ===========================
# Httpd Setting
# ===========================
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
RUN sed -i.org '/#AddHandler cgi-script/s/#//' /etc/httpd/conf/httpd.conf
RUN sed -i    "/^#NameVirtualHost \*:80$/ s/#NameVirtualHost \*:80/NameVirtualHost \*:80/" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/KeepAlive Off/KeepAlive On/g" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
RUN sed -i -e "s/DirectoryIndex index.html index.html.var/DirectoryIndex index.html index.php/g" /etc/httpd/conf/httpd.conf
RUN sed -i '$a\LoadModule include_module modules/mod_include.so' /etc/httpd/conf/httpd.conf
RUN sed -i '$a\LoadModule filter_module modules/mod_filter.so' /etc/httpd/conf/httpd.conf

# Remi リポジトリの追加
# Rocky LinuxでもEPELリポジトリは利用できますが、RemiリポジトリのURLが変更される可能性があるので確認してください。
RUN dnf -y install epel-release
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# ===========================
# Perl・DB・Dnfリポジトリ・CAPN
# ===========================
RUN dnf -y install perl-CGI perl-CPAN "perl(Module::Build)" "perl(DBD::mysql)"

# ===========================
# 必須モジュール
# ===========================
RUN dnf -y install "perl(Image::Magick)" "perl(Digest::MD5)" "perl(Mozilla::CA)" "perl(HTML::Entities)"

# ===========================
# Movable Type Setting
# ===========================
RUN mkdir -p /var/www/local/html
RUN mkdir -p /var/www/local/cgi-bin
ADD mt-data/${MT_FILE}.zip /var/www/local/cgi-bin/
RUN unzip /var/www/local/cgi-bin/${MT_FILE}.zip -d '/var/www/local/cgi-bin/'
RUN mv /var/www/local/cgi-bin/${MT_FILE} /var/www/local/cgi-bin/mt
RUN chown -R apache:apache /var/www/local/html
RUN chown -R apache:apache /var/www/local/cgi-bin/mt
RUN chmod 777 /var/www/
RUN chmod 777 /var/www/local
RUN chmod 777 /var/www/local/html
RUN chmod 755 /var/www/local/cgi-bin/mt/*.cgi

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]