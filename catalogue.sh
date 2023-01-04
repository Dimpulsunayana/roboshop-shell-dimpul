script_location=$(pwd)

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

#intall nodejs app
yum install nodejs -y

#create an user
useradd roboshop

#create a directory called app
mkdir /app
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

npm install

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
#labauto mongodb-client

mongo --host localhost </app/schema/catalogue.js

systemctl enable catalogue
systemctl start catalogue