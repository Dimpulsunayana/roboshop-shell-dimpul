script_location=$(pwd)
log=/tmp/roboshop.log

status_check(){
  if [ $? -eq 0 ]
  then echo -e "\e[35mSUCCESS\e[0m"
  else echo -e "\e[31mFAILURE\e[0m"
  fi
}

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
echo -e "\e[35mdownloaded nodejs app\e[0m"
status_check

#intall nodejs app
yum install nodejs -y &>>${log}
echo -e "\e[35mnodejs installed\e[0m"
status_check

#create an user
useradd roboshop &>>${log}
echo -e "\e[35muser created to roboshop\e[0m"
status_check

#create a directory called app
mkdir -p /app &>>${log}
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
rm -rf /app/* &>>${log}
status_check

cd /app
unzip /tmp/catalogue.zip &>>${log}
echo -e "\e[35mextracted catalogue file\e[0m"
status_check

npm install &>>${log}

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${log}

systemctl daemon-reload &>>${log}

cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log}
yum install mongodb-org-shell -y &>>${log}
echo -e "\e[35minstalled mongodb\e[0m"
status_check
#labauto mongodb-client

mongo --host mongodb-dev.dimpul.online </app/schema/catalogue.js &>>${log}

systemctl enable catalogue &>>${log}
systemctl start catalogue &>>${log}
echo -e "\e[35mrestarted catalogue\e[0m"
status_check