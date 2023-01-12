source files/commonfile.sh

yum install maven -y &>>${log}
print_head "installed maven"
status_check

useradd roboshop &>>${log}
print_head "user created"
status_check

mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${log}
cd /app
unzip /tmp/shipping.zip &>>${log}

cd /app
mvn clean package &>>${log}
mv target/shipping-1.0.jar shipping.jar &>>${log}

cp ${script_location}/files/shipping.service /etc/systemd/system/shipping.service &>>${log}

systemctl daemon-reload &>>${log}

labauto mysql-client &>>${log}

mysql -h mysql-dev.dimpul.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>${log}

systemctl enable shipping

systemctl start shipping
print_head "restarted shipping"
status_check