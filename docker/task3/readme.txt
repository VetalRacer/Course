You can use automatization for check home task3

chmod -x sh scripts

------
run 01_prepare_registry.sh for prepare local docker registry, push nginx and
httpd images and clean docker images
------
run docker-compose up

192.168.52.10:8082 - nginx
192.168.53.10:8083 - httpd

run docker-compose down
------
run 02_delete_registry.sh for delete local docker registry and clean docker
images
