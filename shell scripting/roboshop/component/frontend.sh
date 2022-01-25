#!/bin/bash

source component/common.sh

print "Installing nginx"
yum install nginx -y &>>$LOG
stat $?

print "Enabling nginx"
systemctl enable nginx
stat $?

print "starting nginx"
systemctl start nginx
stat $?

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf*
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx
