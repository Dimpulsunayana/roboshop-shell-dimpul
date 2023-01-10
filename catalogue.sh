source files/commonfile.sh

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
print_head "downloaded nodejs app"
status_check

#intall nodejs app
yum install nodejs -y &>>${log}
print_head "nodejs installed"
status_check

#create an user
useradd roboshop &>>${log}
print_head "user created to roboshop"
status_check

#create a directory called app
mkdir -p /app &>>${log}
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
rm -rf /app/* &>>${log}
status_check

cd /app
unzip /tmp/catalogue.zip &>>${log}
print_head "extracted catalogue file"
status_check

npm install &>>${log}

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${log}

systemctl daemon-reload &>>${log}

cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log}
yum install mongodb-org-shell -y &>>${log}
print_head "installed mongodb"
status_check
#labauto mongodb-client

mongo --host mongodb-dev.dimpul.online </app/schema/catalogue.js &>>${log}

systemctl enable catalogue &>>${log}
systemctl start catalogue &>>${log}
print_head "restarted catalogue"
status_check