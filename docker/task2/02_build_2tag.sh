#/bin/bash

echo -e "\n\e[1;32mBuild 2tag image...\e[0m \n"
docker build -f Dockerfile_nginx -t localhost:5000/nginx.loc:tag_one -t localhost:5000/nginx.loc:tag_two .
