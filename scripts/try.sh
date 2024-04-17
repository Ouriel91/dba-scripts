#! /bin/bash

#!/bin/bash

read hours
read minutes
read seconds

h_prt=''
m_prt=''
s_prt=''

if [ $hours -lt 10 ]; then
h_prt="0$hours"
else
h_prt="$hours"
fi

if [ $minutes -lt 10 ]; then
m_prt="0$x"
else
m_prt="$x"
fi

if [ $seconds -lt 10 ]; then
s_prt="0$x"
else
s_prt="$x"
fi

echo $s_prt
echo "RMAN BACKUP COMPLETED $h_prt:$m_prt:$s_prt"
#sqlplus / as sysdba << EOF
#set timing on; 
#select count(*) from try_tb;
#exit;
#EOF

# Iterate over files in the current directory

#con_files=()
#for file in $(ls /opt/oracle/homes/OraDB21Home1/dbs/c-*); do
#    con_files+=("$file")
#done

#for index in "${!con_files[@]}"; do
#    echo "$index: ${con_files[index]}"
#done

#read -p "Enter the index of the element you want to access: " index
#selection=''
# Validate the index
#if [[ $index =~ ^[0-9]+$ && $index -ge 0 && $index -lt ${#con_files[@]} ]]; then
    # Access the element at the specified index
#    selection="${con_files[index]}"
#else
#    echo "Invalid index. Please enter a valid index within the range of the array."
#fi

#echo $selection

#echo ${con_files[3]}

#for file in "${con_files[@]}"; do
#    echo "File: $file"
#done

#ID_VAL=$(sqlplus -s / as sysdba <<END
#set head off
#set feedback off
#set pagesize 2400
#set linesize 2048
#select CURRENT_SCN from v\$database;
#exit;
#END
#)

echo $ID_VAL

#echo "Restore until by:"
#echo "1. Minutes"
#echo "2. Hours"
#echo "3. Days"
#echo "exit. Exit from menu "
#echo -n "Enter your menu choice [1-3] or exit:"

# reading choice
#read choice
#time_back=$(date)
# case statement is used to compare one value with the multiple cases.
#case $choice in
  # Pattern 1
#  1)  echo "Enter Minutes back:"
#      read answer
#      time_back=$(date '+%d-%m-%Y %H:%M:%S' -d "-$answer minute")
#      ;;

#  2)echo "Enter Hours back:"
#      read answer
#      time_back=$(date '+%d-%m-%Y %H:%M:%S' -d "-$answer hour")
#     ;;

#  3)  echo "Enter days back:"
#      read answer
#      time_back=$(date '+%d-%m-%Y %H:%M:%S' -d "-$answer day")
#      ;;

#  exit)  echo "Quitting ..."
#      exit;;
  # Default Pattern
#  *) echo "invalid option";;
#esac

#echo $time_back
