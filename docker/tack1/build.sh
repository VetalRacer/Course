#/bin/bash

echo -e "\n\e[1;32mBuild first nginx image...\e[0m \n"
docker build -f Dockerfile_p8082 -t nginx8082 .
echo -e "\n\e[1;32mBuild second nginx image...\e[0m \n"
docker build -f Dockerfile_p8083 -t nginx8083 .
