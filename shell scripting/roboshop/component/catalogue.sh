#!/bin/bash

source common.sh

print "Install Nodejs"
yum install -y gcc-c++ make &>>$LOG
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash - &>>$LOG
yum install -y nodejs &>>$LOG
stat $?