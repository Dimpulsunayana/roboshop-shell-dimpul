source files/commonfile.sh

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
print_head "downloaded nodejs app"
status_check

#intall nodejs app
yum install nodejs -y &>>${log}
print_head "nodejs installed"
status_check

#create an user
id roboshop &>>${log}
if [ $? -ne 0 ]
then
useradd roboshop &>>${log}
fi
print_head "user created to roboshop"
status_check

#create a directory called app
mkdir -p /app &>>${log}
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log}
rm -rf /app/* &>>${log}
status_check

cd /app
unzip /tmp/user.zip &>>${log}
print_head "extracted catalogue file"
status_check

npm install &>>${log}


cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log}
yum install mongodb-org-shell -y &>>${log}
print_head "installed mongodb"
status_check
#labauto mongodb-client

systemctl daemon-reload &>>${log}

mongo --host mongodb-dev.dimpul.online </app/schema/user.js &>>${log}

systemctl enable user &>>${log}
systemctl start user &>>${log}
print_head "restarted user"
status_check