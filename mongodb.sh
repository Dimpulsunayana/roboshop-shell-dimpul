#Checking the current dir and storing it(like a variable) to use further
script_location=$(pwd)

#create reverse proxy conf
cp ${script_location}/files/mongodb.sh /etc/yum.repos.d/mongo.repo

#install mongod server
yum install mongodb-org -y

#sed -stream line editor
# -e is to verify and -i is proceed to change
#here its replacing 127.0.0.1 to 0.0.0.0
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

systemctl enable mongod
systemctl restart mongod