#!/bin/bash

print() {
  echo -n -e "\e[1m$1\e[0m.."
  echo -e "\n\e[36m..............1$..............\e[0m" >>$LOG
}

stat() {
  if [ $1 -eq 0 ];
  then
    echo -e "\e[1;32mSUCESS\e[0m"
  else
    echo -e "\e[1;33mFAILURE\e[0m"
    echo -e "\e[1;34mscript the failed and check detailed log in $LOG file \e[0m"
 fi
}

LOG=/tmp/roboshop.log
rm -f $LOG

DOWNLOAD() {
  print "Download $COMPONENT_NAME"
  curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
  stat $?

  print "Extract $COMPONENT_NAME"
  unzip -o -d $1 /tmp/$COMPONENT.zip &>>$LOG
  stat $?
}
Nodejs() {

print "Install Nodejs"
yum install -y gcc-c++ make &>>$LOG
curl -s -L https://rpm.nodesource.com/setup_6.x | sudo -E bash - &>>$LOG
yum install -y nodejs &>>$LOG
stat $?

print "Add roboshop user"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
  echo user Roboshop already exists &>>$LOG
else
  useradd roboshop &>>$LOG
fi
stat $?

print "Remove old content"
rm -rf /home/roboshop/$COMPONENT
stat $?

DOWNLOAD '/home/roboshop'

print "copy content"
mv /home/roboshop/$COMPONENT-main /home/roboshop/$COMPONENT
stat $?

print "Nodejs dependecies"
npm install --unsafe-perm &>>$LOG
stat $?

print "Fix app permissions"
chown -R roboshop:roboshop /home/roboshop
stat $?

print "update DNS records in systemD config"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" /home/roboshop/$COMPONENT/systemd.service &>>$LOG
stat$?

print "copy systemd file"
mv /home/roboshop/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat$?

print "start catalogue service"
systemctl daemon-reload &>>$LOG && systemctl restart $COMPONENT &>>$LOG && systemctl enable $COMPONENT &>>$LOG
stat$?

}