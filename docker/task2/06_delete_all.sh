#/bin/bash

echo -e "\n\e[1;31m Delete 2tag image...\e[0m \n"
docker rmi localhost:5000/nginx.loc:tag_one
docker rmi localhost:5000/nginx.loc:tag_two

echo -e "\n\e[1;31m Delete registry...\e[0m \n"
docker stop registry.loc && docker rm registry.loc
docker rmi registry:2
