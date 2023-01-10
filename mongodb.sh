#Checking the current dir and storing it(like a variable) to use further
source files/commonfile.sh

#create reverse proxy conf
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo  &>>${log}
print_head "created proxy conf"
status_check

#install mongod server
yum install mongodb-org -y  &>>${log}
print_head "installed mongodb"
status_check

#sed -stream line editor
# -e is to verify and -i is proceed to change
#here its replacing 127.0.0.1 to 0.0.0.0
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf  &>>${log}

systemctl enable mongod  &>>${log}
systemctl restart mongod  &>>${log}
print_head "mongodb restarted"
status_check