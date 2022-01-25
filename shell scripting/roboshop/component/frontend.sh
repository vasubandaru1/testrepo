#!/bin/bash


print() {
  echo -n -e '\e[1m$1\e[0m..'
  echo -e '\n\e[36m............. $1 .............\e[0m' >>$LOG
}

stat() {
  if [ $1 -eq 0 ]; then
    echo -e '\e[1;32mSUCESS\e[0m'
   else
    echo -e "\e[1;33mFAILURE\e[0m"
     echo -e "\e[1;34mscript the failed and check detailed log in $LOG file \e[0m"
 fi
}

LOG=/tmp/roboshop.log
rm -f $LOG

print "Installing nginx"
yum install nginx -y &>>$LOG
stat $?
exit
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
