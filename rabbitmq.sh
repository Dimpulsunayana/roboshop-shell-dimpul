source files/commonfile.sh

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${log}
print_head "copied rabbitmq conf"
status_check

yum install erlang -y &>>${log}
print_head "installed erlang"
status_check

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${log}
print_head "downloaded rabbitmq repo"
status_check

yum install rabbitmq-server -y &>>${log}
print_head "installed rabbitmq server"
status_check

systemctl enable rabbitmq-server &>>${log}
systemctl start rabbitmq-server &>>${log}

rabbitmqctl add_user roboshop roboshop123 &>>${log}
rabbitmqctl set_user_tags roboshop administrator &>>${log}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log}