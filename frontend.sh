script_location=$(pwd)
#install nginx server
yum install nginx -y
echo -e "\e[34mnginx installed\e[0m"

#Remove default content in nginx webser server is running
rm -rf /usr/share/nginx/html/*
echo -e "\e[34mdefault content is removed\e[0m"

#download the roboshop-frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

#extract the frontend file
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#create reverse proxy conf
cp ${script_location}/files/frontend_conf.sh /etc/nginx/default.d/roboshop.conf

#enable and start nginx server
systemctl enable nginx
systemctl restart nginx
echo -e "\e[34mnginx restarted\e[0m"