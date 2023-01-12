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
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${log}
rm -rf /app/* &>>${log}
status_check

cd /app
unzip /tmp/cart.zip &>>${log}
print_head "extracted catalogue file"
status_check

npm install &>>${log}

cp ${script_location}/files/cart.service /etc/systemd/system/cart.service &>>${log}
print_head "copied cart conf"
status_check
#labauto mongodb-client

systemctl daemon-reload &>>${log}

systemctl enable cart &>>${log}
systemctl start cart &>>${log}
print_head "restarted cart"
status_check