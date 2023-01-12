source files/commonfile.sh

yum install golang -y &>>${log}
print_head "installed golang"
status_check

useradd roboshop &>>${log}

mkdir /app &>>${log}

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>${log}
cd /app &>>${log}
unzip /tmp/dispatch.zip &>>${log}

cd /app
go mod init dispatch &>>${log}
go get &>>${log}
go build &>>${log}

cp ${script_location}/files/dispatch.service /etc/systemd/system/dispatch.service &>>${log}

systemctl daemon-reload &>>${log}

systemctl enable dispatch &>>${log}
systemctl start dispatch &>>${log}