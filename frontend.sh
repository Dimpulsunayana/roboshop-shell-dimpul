#install nginx server
yum install nginx -y

#Remove default content in nginx webser server is running
rm -rf /usr/share/nginx/html/*

#download the roboshop-frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

#extract the frontend file
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#create reverse proxy conf
vim /etc/nginx/default.d/roboshop.conf

#enable and start nginx server
systemctl enable nginx
systemctl restart nginx