source files/commonfile.sh

if [ -z "${root_mysql_password}" ]; then
  echo "Variable root_mysql_password is missing"
  exit 1
fi

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
print_head "enabled mysqld"
status_check

systemctl start mysqld &>>${log}
print_head "restarted mysqld"
status_check

#mysql_secure_installation --set-root-pass RoboShop@1 &>>${log}
print_head "Reset Default Database Password"
mysql_secure_installation --set-root-pass ${root_mysql_password} &>>${log}
status_check
#print_head "root pwd got set"
#status_check

mysql -uroot -pRoboShop@1 &>>${log}
print_head "user root pwd got set"
status_check