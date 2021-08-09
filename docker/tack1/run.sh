#/bin/bash

echo -e "\n\e[1;32m Run first nginx image...\e[0m \n"
docker run -d -p 8082:8082 --name nginx8082 nginx8082
echo -e "\n\e[1;32m Run second nginx image...\e[0m \n"
docker run -d -p 8083:8083 --name nginx8083 nginx8083
