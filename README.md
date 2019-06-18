# DOCKER cheat sheet

### IMAGES
> images บรรจุ container เอาไว้ไป run ที่เครื่องอื่น อัพขึ้น hub ได้
#### List all images
`docker images`

#### Remove image
`docker rm {id}`

#### Remove all images
`docker rmi $(docker images -q)`


### CONTAINER
> Container คือรวมโปรแกรมเอาไว้ run
#### List all container
`docker container ls`
> ls -a ดู status
`docker container ls -a`
`docker ps -aq`

#### Run container from HUB
ถ้า run ไม่ได้ให้ลอง remove container ที่อยู่ใน docker container ls -a ออก หรือไม่ก็ restart docker

```
docker container run -it -p 8080:80 --name mynginx nginx
```
+ -it คือ iteractive mode
+ -p = publish
+ -d = run background
+ 8080:80 = localhost:container
+ mynginx = คือชื่อ conainer
+ nginx คือ official image ใน hub
  + apache คือ httpd 
  + mysql คือ mysql

> ตัวอย่าง mysql ที่ต้องตั้งค่า password ด้วย
```
docker container run -d -p 3306:3306 --name mysql --env MYSQL_ROOT_PASSWORD=1234 mysql
```

#### Run container from container ที่เราสร้างไว้
`docker container run mynginx`


#### Stop all containers
`docker stop $(docker ps -aq)`

#### Remove all containers
`docker rm -f $(docker ps -aq)`
+ -f คือ force remove

#### เข้าไปดูข้อมูลใน container 
`docker container exec -it mynginx bash`
+ ถ้า windows ต้องมีคำว่า winpty

#### bind mount (sync localhost กับ folder ใน container)
```docker container run -d -p 8080:80 -v $(pwd -W):/usr/share/nginx/html --name nginx-website nginx```

*ถ้า windows ต้องมีคำว่า winpty กับ /$(pwd) แทน current directory *

```docker container run -d -p 8080:80 -v /$(pwd -W):/usr/share/nginx/html --name nginx-website nginx```

### Dockerfile
*Build image base on Dockerfile*
```
docker image build -t arigatopix/nginx-website:v1 .
```
+ -t คือ tag
+ argatopix คือ username
+ nginx-website:v1 คือ --name:tag
+ อย่าลืมจุด (.)

> ลองเช็คว่ามี images มั้ย  จะเห็น tag
`docker images`

#### Run image
`docker container run -d -p 8080:80 arigatopix/nginx-website:v1.0`

#### กรณีมีแก้ไข
`docker container stop {id}`

#### rebuild image
`docker build -t arigatopix/nginx-wetsite:v1.0`

#### re-run
`docker container run -d -p 8080:80 arigatopix/nginx-website:v1.0`


### PUSH Dockerfile
`docker push arigatopix/nginx-website:v1.0`