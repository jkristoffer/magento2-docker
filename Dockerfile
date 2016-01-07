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
