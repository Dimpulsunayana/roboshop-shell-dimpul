source commonfile.sh

#install nginx server
yum install nginx -y &>>${log}
echo -e "\e[35mnginx installed\e[0m"
status_check

#Remove default content in nginx webser server is running
rm -rf /usr/share/nginx/html/* &>>${log}
echo -e "\e[35mdefault content is removed\e[0m"
status_check

#download the roboshop-frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
echo -e "\e[35mdownloaded the fronted content\e[0m"
status_check

#extract the frontend file
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log}
echo -e "\e[35munzipped the file\e[0m"
status_check

#create reverse proxy conf
cp ${script_location}/files/frontend_conf.sh /etc/nginx/default.d/roboshop.conf &>>${log}
echo -e "\e[35mcreated rev proxy\e[0m"
status_check

#enable and start nginx server
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}
echo -e "\e[35mnginx restarted\e[0m"
status_check