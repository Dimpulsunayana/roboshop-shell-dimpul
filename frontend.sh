script_location=$(pwd)
log=/tmp/roboshop.log

#install nginx server
yum install nginx -y &>>${log}
echo -e "\e[35mnginx installed\e[0m"
echo $?

#Remove default content in nginx webser server is running
rm -rf /usr/share/nginx/html/* &>>${log}
echo -e "\e[35mdefault content is removed\e[0m"
echo $?

#download the roboshop-frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
echo $?

#extract the frontend file
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log}
echo $?

#create reverse proxy conf
cp ${script_location}/files/frontend_conf.sh /etc/nginx/default.d/roboshop.conf &>>${log}
echo $?

#enable and start nginx server
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}
echo -e "\e[35mnginx restarted\e[0m"
echo $?