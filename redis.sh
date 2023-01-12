#Checking the current dir and storing it(like a variable) to use further
source files/commonfile.sh

yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log}
print_head "install redis repo"
status_check

dnf module enable redis:remi-6.2 -y &>>${log}
print_head "enable redis 6.2 v"
status_check

#install mongod server
yum install redis -y  &>>${log}
print_head "installed redis"
status_check

#sed -stream line editor
# -e is to verify and -i is proceed to change
#here its replacing 127.0.0.1 to 0.0.0.0
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf  &>>${log}

systemctl enable redis  &>>${log}
systemctl restart redis  &>>${log}
print_head "redis restarted"
status_check