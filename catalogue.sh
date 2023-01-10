script_location=$(pwd)
log=/tmp/roboshop.log

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
echo -e "\e[35mdownloaded nodejs app\e[0m"
if [ $? -eq 0 ]
then echo SUCCESS
else echo Fail
fi

#intall nodejs app
yum install nodejs -y &>>${log}
echo -e "\e[35mnodejs installed\e[0m"
if [ $? -eq 0 ]
then echo SUCCESS
else echo Fail
fi

#create an user
useradd roboshop &>>${log}
echo -e "\e[35muser created to roboshop\e[0m"
#if [ $? -eq 0 ]
#then echo SUCCESS
#else echo Fail
#fi

#create a directory called app
mkdir -p /app &>>${log}
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
rm -rf /app/* &>>${log}
if [ $? -eq 0 ]
then echo SUCCESS
else echo Fail
fi
cd /app
unzip /tmp/catalogue.zip &>>${log}
echo -e "\e[35mextracted catalogue file\e[0m"
if [ $? -eq 0 ]
then echo SUCCESS
else echo Fail
fi

npm install &>>${log}

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${log}

systemctl daemon-reload &>>${log}

cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log}
yum install mongodb-org-shell -y &>>${log}
echo -e "\e[35minstalled mongodb\e[0m"
if [ $? -eq 0 ]
then echo SUCCESS
else echo Fail
fi
#labauto mongodb-client

mongo --host mongodb-dev.dimpul.online </app/schema/catalogue.js &>>${log}

systemctl enable catalogue &>>${log}
systemctl start catalogue &>>${log}
echo -e "\e[35mrestarted catalogue\e[0m"
if [ $? -eq 0 ]
then echo SUCCESS
else echo Fail
fi