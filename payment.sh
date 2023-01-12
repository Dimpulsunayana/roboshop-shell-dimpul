source files/commonfile.sh

yum install python36 gcc python3-devel -y &>>${log}
print_head "installed python36"
status_check

useradd roboshop &>>${log}
print_head "user created"
status_check

mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>${log}
cd /app &>>${log}
unzip /tmp/payment.zip &>>${log}

cd /app
pip3.6 install -r requirements.txt &>>${log}

cp ${script_location}/files/payment.service /etc/systemd/system/payment.service &>>${log}

systemctl daemon-reload &>>${log}

systemctl enable payment
systemctl start payment