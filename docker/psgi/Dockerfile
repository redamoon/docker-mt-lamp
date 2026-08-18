# Rocky Linux 9 / Movable Type PSGI runtime (plackup / Starman)
FROM rockylinux:9

ARG MT_FILE="local"
LABEL maintainer="redamoon"
USER root

RUN dnf -y clean all \
    && dnf update -y \
    && dnf install -y git unzip glibc \
    && dnf clean all

RUN dnf -y install epel-release \
    && dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm \
    && dnf -y install dnf-plugins-core \
    && dnf config-manager --enable crb

RUN dnf -y install perl-CGI perl-CPAN "perl(Module::Build)" "perl(DBD::mysql)"
RUN dnf -y install "perl(Image::Magick)" "perl(Digest::MD5)" "perl(Mozilla::CA)" "perl(HTML::Entities)" perl-JSON-XS

# PSGI: dnf を優先。無いパッケージだけ cpanm（ビルドが長くなりやすいので成功時は使わない）
# Starman も入れておき、後続の Apache+Starman モードでイメージを作り直さない
# CGI::Compile / CGI::Emulate::PSGI は Plack::App::WrapCGI と mt.psgi が要求する
RUN dnf -y install perl-App-cpanminus gcc make perl-devel
RUN dnf -y install "perl(Plack)" "perl(CGI::Parse::PSGI)" "perl(CGI::PSGI)" "perl(CGI::Compile)" "perl(CGI::Emulate::PSGI)" "perl(Starman)" \
    || cpanm -n --notest Plack CGI::PSGI CGI::Parse::PSGI CGI::Compile CGI::Emulate::PSGI Starman

RUN mkdir -p /var/www/local/html /var/www/local/cgi-bin /var/www/local/logs
ADD mt-data/${MT_FILE}.zip /var/www/local/cgi-bin/
RUN unzip /var/www/local/cgi-bin/${MT_FILE}.zip -d '/var/www/local/cgi-bin/' \
    && mv /var/www/local/cgi-bin/${MT_FILE} /var/www/local/cgi-bin/mt \
    && chmod 755 /var/www/local/cgi-bin/mt/*.cgi

COPY psgi/start-plackup.sh /usr/local/bin/start-plackup.sh
COPY psgi/start-starman.sh /usr/local/bin/start-starman.sh
RUN chmod +x /usr/local/bin/start-plackup.sh /usr/local/bin/start-starman.sh

WORKDIR /var/www/local/cgi-bin/mt
EXPOSE 5000
CMD ["/usr/local/bin/start-plackup.sh"]
