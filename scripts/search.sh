#! /bin/bash
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)
hour_back=$(date '+%d-%m-%Y %H:%M:%S' -d "-1 hour")

# creating a menu with the following options
echo "SELECT WHAT YOU WANT TO CHECK";
echo "1. List Backup"
echo "2. Specific Datafile Backup"
echo "3. List Backup of database"
echo "4. List Backup archive log"
echo "5. List Backup control file"
echo "6. List backup spfile"
echo "7. List archive log"
echo "8. List specific backupset"
echo "9. List datafilecopy"
echo "10. List specific datafile copy"
echo "11. List copy of control file"
echo "12. List specific control file"
echo "13. List backup specific tablespce"
echo "14. List incarnation"
echo "15. List backup summary"
echo "exit. Exit from menu "
echo -n "Enter your menu choice [1-15] or exit:"

# Running a forever loop using while statement
# This loop will run until select the exit option.
# User will be asked to select option again and again
while :
do

# reading choice
read choice

# case statement is used to compare one value with the multiple cases.
case $choice in
  # Pattern 1
  1)  echo "List Backup:"
      rman target / <<EOF
      LIST BACKUP;
      quit;
EOF
;;
  
  2)echo "Enter number of datafile or datafile path (enter in quotes):"
      read answer
      rman target / <<EOF
      LIST BACKUP OF DATAFILE $answer;
      quit;
EOF
     ;;
  
  3)  echo "List Backup of database"
      rman target / <<EOF
      LIST BACKUP OF DATABASE;
      quit;
EOF
      ;;    
  4)  echo "List Backup of archive log"
      rman target / <<EOF
      LIST BACKUP OF ARCHIVELOG ALL;
      quit;
EOF
      ;;

  5)  echo "List Backup of control file"
      rman target / <<EOF
      LIST BACKUP OF CONTROLFILE;
      quit;
EOF
      ;;

  6)  echo "List Backup of spfile"
      rman target / <<EOF
      LIST BACKUP OF SPFILE;
      quit;
EOF
      ;;
  7)  echo "List Archive log"
      rman target / <<EOF
      LIST ARCHIVELOG ALL;
      quit;
EOF
      ;;
  8)  echo "Enter number of backupset"
      read answer
      rman target / <<EOF
      LIST BACKUPSET $answer;
      quit;
EOF 
     ;;

  9)  echo "List of datafile copy"
      rman target / <<EOF
      LIST DATAFILECOPY ALL;
      quit;
EOF
      ;;

  10) echo "Enter number of datafile copy or path (in quotes)"
      read answer
      rman target / <<EOF
      LIST DATAFILECOPY  $answer;
      quit;
EOF
   ;;

  11) echo "List copy controlfile"
      rman target / <<EOF
      LIST COPY OF CONTROLFILE;
      quit;
EOF
      ;;

  12) echo "Enter number of copy controlfile or path "
      read answer
      rman target / <<EOF
      LIST CONTROLFILECOPY  $answer;
      quit;
EOF
   ;;

  13) echo "Enter name of tablespace backup with capital letters"
      read answer
      rman target / <<EOF
      LIST BACKUP OF TABLESPACE '$answer';
      quit;
EOF
   ;;
  
  14) echo "List incarnation"
      rman target / <<EOF
      LIST INCARNATION;
      quit;
EOF
      ;;
  15) echo "List backup summary"
      rman target / <<EOF
      LIST BACKUP SUMMARY;
      quit;
EOF
      ;;
  exit)  echo "Quitting ..."
      exit;;
  # Default Pattern
  *) echo "invalid option";;
  
esac
  echo -n "Enter your menu choice [1-14] or exit: "
done

