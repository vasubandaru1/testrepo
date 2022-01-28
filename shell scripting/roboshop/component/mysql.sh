#!/bin/bash

source common.sh

print "Download Mysql repos"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>$LOG
stat $?

print "Install Mariadb service"
 yum remove mariadb-libs -y &>>$LOG && yum install mysql-community-server -y &>>$LOG
 stat $?

print "Start mysql sevice"
systemctl enable mysqld &>>$LOG && systemctl start mysqld &>>$LOG
stat $?

DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
NEW_PASSWORD=roboshop@1

echo 'show databases;' | mysql -uroot -p'${NEW_PASSWORD}' &>>$LOG
if [ $? -ne 0 ]; then
print "changing the DEFAULT_PASSWORD"
echo -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_PASSWORD}';\nuninstall plugin validate_password;" >/tmp/pass.sql
mysql --connect-expired-password -uroot -p "${DEFAULT_PASSWORD}" </tmp/pass.sql &>>$LOG
stat $?
fi
exit


Shipping Service
So we need to load that schema into the database, So those applications will detect them and run accordingly.

To download schema, Use the following command

# curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
Load the schema for Services.

# cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -pRoboShop@1 <shipping.sql