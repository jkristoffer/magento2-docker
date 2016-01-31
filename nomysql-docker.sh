docker run --name mysql-1 -e MYSQL_DATABASE=magento -e MYSQL_USER=magento -e MYSQL_PASSWORD=magento -d mysql:5.6 && \
docker run --name magento2 --link mysql-1:mysql -dP jkristoffer/magento2:0.1