#Mangeto - Docker

Base Image: Centos:6

Installs:
* apache
* redis
* composer
* php 5.6

Requires:
* external running mysql container `link <mysql-container-name/id>:mysql`
* [Magento Connect Authentication](http://devdocs.magento.com/guides/v2.0/install-gde/prereq/connect-auth.html)
* [Github OAuth Keys](https://github.com/settings/tokens/new?scopes=repo) 

Building the docker file:

`docker build --t <your-namespace>/magento2:latest .`

Fill in required creds in `./conf.d/auth.json` and `./conf.d/github.auth.json`

Set up mysql container:

`docker run --name my-mysql -e MYSQL_ROOT_PASSWORD=magento2 -e MYSQL_DATABASE=magento2 -e MYSQL_USER=magento2 -e MYSQL_PASSWORD=magento2 -d mysql:5.7`

Fire up your very own magento2 container! 

`docker run -d --name magento2 --link my-mysql:mysql <your-namespace>/magento2:latest`

