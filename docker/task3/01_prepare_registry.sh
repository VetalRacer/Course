#/bin/bash

echo -e "\n\e[1;32m Run registry...\e[0m \n"
docker run -d -p 5000:5000 --name registry.loc registry:2

echo -e "\n\e[1;32mBuild first nginx image...\e[0m \n"
docker build -f Dockerfile_nginx -t localhost:5000/nginx.loc .
echo -e "\n\e[1;32mBuild second nginx image...\e[0m \n"
docker build -f Dockerfile_httpd -t localhost:5000/httpd.loc .

echo -e "\n\e[1;32mPush images to loc registry...\e[0m \n"
docker push localhost:5000/nginx.loc 
docker push localhost:5000/httpd.loc

echo -e "\n\e[1;32mCreate networks...\e[0m \n"
docker network create 

echo -e "\n\e[1;31m Delete 2tag image...\e[0m \n"
docker rmi localhost:5000/nginx.loc:latest
docker rmi localhost:5000/httpd.loc:latest
docker rmi nginx:latest httpd:2.4
