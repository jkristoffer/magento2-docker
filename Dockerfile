FROM centos:6

# Install prerequisites 
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm && \
    rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-4.0.el6.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    yum -y update && \
    yum -y --enablerepo=remi,remi-test install curl wget httpd git mysql epel-release php56w php56w-opcache php56w-xml php56w-mcrypt php56w-gd php56w-devel php56w-mysql php56w-intl php56w-mbstring php56w-bcmath install redis varnish && \
    cd /var/www/html && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Copy configuration files
COPY ./conf.d/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./conf.d/php.ini /etc/php.ini
COPY ./conf.d/auth.json /root/auth.json
COPY ./conf.d/github.auth.json /root/.composer/auth.json

# Start MySQL Service
RUN service mysqld start

# GIT Clone lastest Magento2 Repo and Install
RUN cd /var/www/html && git clone https://github.com/magento/magento2.git && cd magento2 &&\
    composer install && \
    ./bin/magento setup:install \
        --admin-firstname==Jane \
        --admin-lastname=Doe \
        --admin-email=your.mail@mail.com \
        --admin-user=admin \
        --admin-password='Gl0r10u5F00d' \
        --db-prefix=mage \
        --language=en_US \
        --currency=SGD \
        --timezone=Asia/Singapore \
        --session-save=db

# Set File Permissions
RUN find . -type d -exec chmod 770 {} \; && find . -type f -exec chmod 660 {} \; && chmod u+x bin/magento && \
    cd /var/www/html/magento2 && chown -R :apache .

# Copy post-install configurations
COPY ./conf.d/env.php /var/www/html/magento2/app/etc/env.php
COPY ./conf.d/default.vcl /etc/varnish/default.vcl
COPY ./conf.d/varnish /etc/sysconfig/varnish

# Start Apache, Redis and Varnish
RUN service httpd restart && \
    /etc/init/redis start && \
    varnishd -d -f /etc/varnish/default.vcl

# Expose Port 80 for Apache web service and Port 3306 for MySQL daemon
EXPOSE 80, 3306
