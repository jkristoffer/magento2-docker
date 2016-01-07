Building the docker file:

`docker build --t <your-namespace>/magento2:latest .`

Fill in required creds in `./conf.d/auth.json` and `./conf.d/github.auth.json`

Set up mysql container:

`docker run --name my-mysql -e MYSQL_ROOT_PASSWORD=magento2 -e MYSQL_DATABASE=magento2 -e MYSQL_USER=magento2 -e MYSQL_PASSWORD=magento2 -d mysql:5.7`

Fire up your very own magento2 container! 

`docker run -d --name magento2 --link my-mysql:mysql <your-namespace>/magento2:latest`

