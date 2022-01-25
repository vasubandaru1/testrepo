#!/bin/bash

source common.sh

print "Installing nginx"
yum install nginx -y &>>$LOG
stat $?

print "Enabling nginx"
systemctl enable nginx &>>$LOG
stat $?

print "starting nginx"
systemctl start nginx &>>$LOG
stat $?

print "download the html files"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
stat $?

print "Remove old html files"
rm -rf /usr/share/nginx/html/* &>>$LOG
stat $?

print "Extract the files in to the html file"
unzip -o -d /tmp /tmp/frontend.zip &>>$LOG
stat $?

print "copy files to nginx path"
mv /tmp/frontend-main/static/* /usr/share/nginx/html/. &>>$LOG
stat $?

print "copy nginx roboshop config file"
mv /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
stat $?

print "restart nginx"
systemctl restart nginx
stat $?
