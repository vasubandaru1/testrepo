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