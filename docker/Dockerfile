# Rocky Linuxの最新を指定
FROM rockylinux:9

RUN dnf update -y \
    && dnf install -y php \
    && dnf clean all
#RUN dnf update -y \
#    && dnf -y install nginx \
#    && dnf clean all
RUN mkdir -p /etc/httpd/sites-available /etc/httpd/sites-enable
RUN #sed -i 's/#ServerName.*/ServerName localhost/' /etc/httpd/conf/httpd.conf
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
RUN echo "Include /etc/httpd/sites-enabled" >> /etc/httpd/conf/httpd.conf
#RUN sed -i 's/^#\(Include.*httpd-ssl.conf.*\)/\1/' /etc/httpd/conf/httpd.conf
#RUN sed -i
# enable service.
# RUN systemctl enable httpd

#CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
#CMD ["/usr/sbin/httpd", "-g", "daemon off;", "-DFOREGROUND"]
CMD ["httpd", "-DFOREGROUND"]
EXPOSE 80