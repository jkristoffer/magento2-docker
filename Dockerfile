FROM centos:6

RUN yum -y update && \
    yum -y install curl wget httpd git && \
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm && \
    yum install -y php56w php56w-opcache php56w-xml php56w-mcrypt php56w-gd php56w-devel php56w-mysql php56w-intl php56w-mbstring php56w-bcmath && \
    wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/7/x86_64/e/ && \
    rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    yum -y --enablerepo=remi,remi-test install redis && \
    cd /var/www/html && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY ./conf.d/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./conf.d/php.ini /etc/php.ini
COPY ./conf.d/auth.json /root/auth.json
COPY ./conf.d/github.auth.json /root/.composer/auth.json

RUN cd /var/www/html && git clone https://github.com/magento/magento2.git && \
    cd magento2 && composer install && \
    chown -R :apache . && \
    find . -type d -exec chmod 770 {} \; && find . -type f -exec chmod 660 {} \; && chmod u+x bin/magento

CMD /var/www/html/magento2/bin/magento setup:install --admin-firstname==Jane \
    --admin-lastname=Doe \
    --admin-email=your.mail@mail.com \
    --admin-user=admin \
    --admin-password='Gl0r10u5F00d' \
    --db-host=mysql \
    --db-name=magento2 \
    --db-user=root \
    --db-password=magento2 \
    --db-prefix=mage \
    --language=en_US \
    --currency=SGD \
    --timezone=Asia/Singapore \
    --session-save=db && \
    service httpd restart && \
    cd /var/www/html/magento2 && chown -R :apache . && \
    /bin/bash

EXPOSE 80
