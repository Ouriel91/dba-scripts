#! /bin/bash
echo "Welcome $whoami to backup and restore services app:"
echo "Choose an option:"
echo "1. My information"
echo "2. Regular Backup"
echo "3. Incremental 0 Backup"
echo "4. Incremental 1 Backup"
echo "5. Incremental 1 cum Backup"
echo "6. Incremental 1 diff Backup"
echo "7. Regular Restore"
echo "8. Incomplete restore"
echo "exit. Exit from menu"

while :
do
# reading choice
read choice
# case statement is used to compare one value with the multiple cases.
case $choice in
  # Pattern 1
  1)  echo "Informatio:"
      ./search.sh
      ;;

  2)echo "Regular backup:"
      ./backup.sh
     ;;

  3)  echo "Incremental 0:"
      ./backup_inc_0.sh
      ;;
  4)  echo "Incremental 1:"
      ./backup_inc_1.sh
      ;;
  5)  echo "Incremental 1 cum:"
      ./backup_inc_1_cum.sh
      ;;
  6) echo "Incremental diff:"
     ;;
  7) echo "Restore:"
     ./restore.sh
     ;;
  exit)  echo "Quitting ..."
     exit;;
  # Default Pattern
  *) echo "invalid option";;
esac
  echo -n "Main menu choice [1-8] or exit: "
done
