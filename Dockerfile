# base on image ของ nginx
FROM nginx:latest

# โฟลเดอร์ที่ bind mount หรือต้องการทำงาน
WORKDIR /usr/share/nginx/html

# copy จาก host ไป workdir
COPY . .