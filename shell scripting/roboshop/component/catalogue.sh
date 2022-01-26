#!/bin/bash

source common.sh

print "Install Nodejs"
yum install -y gcc-c++ make &>>$LOG
curl -s -L https://rpm.nodesource.com/setup_6.x | sudo -E bash - &>>$LOG
yum install -y nodejs &>>$LOG
stat $?
exit
print "Add roboshop user"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
  echo user Roboshop already exists &>>$LOG
else
  useradd roboshop &>>$LOG
fi
stat $?

print "Download catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
stat $?

print "Remove old content"
rm -rf /home/roboshop/catalogue
stat $?

print "Extract catalogue"
unzip -o -d /home/roboshop /tmp/catalogue.zip &>>$LOG
stat $?

print "copy content"
mv /home/roboshop/catalogue-main /home/roboshop/catalogue
stat $?

print "Nodejs dependecies"
npm install --unsafe-perm &>>$LOG
stat $?

print "Fix app permissions"
chown -R roboshop:roboshop /home/roboshop
stat $?
