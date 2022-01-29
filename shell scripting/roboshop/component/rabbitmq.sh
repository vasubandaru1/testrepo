#!/bin/bash

source common.sh

COMPONENT_NAME=RabbitMQ
COMPONENT=rabbitmq

print "Install erlang"
yum list installed | grep erlang &>>$LOG
if [ $1 -ne 0 ]; then
 yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>$LOG
 fi
 stat $?

print "Setup YUM repositories for RabbitMQ "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG
stat $?

print "Install RabbitMQ"
yum install rabbitmq-server -y &>>$LOG
stat $?

print "Start RabbitMQ"
systemctl enable rabbitmq-server &>>$LOG && systemctl start rabbitmq-server &>>$LOG
stat $?
exit
#RabbitMQ comes with a default username / password as guest/guest. But this user cannot be used to connect. Hence we need to create one user for the application.

#Create application user
# rabbitmqctl add_user roboshop roboshop123
# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"