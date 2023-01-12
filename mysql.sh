source files/commonfile.sh

dnf module disable mysql -y &>>${log}
print_head "module disabled"
status_check

cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log}
print_head "copied cart conf"
status_check

yum install mysql-community-server -y &>>${log}
print_head "installed mysql"
status_check

systemctl enable mysqld &>>${log}
print_head "enabled mysql"
status_check

systemctl start mysqld &>>${log}
print_head "restarted mysql"
status_check

mysql_secure_installation --set-root-pass RoboShop@1 &>>${log}
print_head "root pwd got set"
status_check

mysql -uroot -pRoboShop@1 &>>${log}
print_head "user root pwd got set"
status_check