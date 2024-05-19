#! /bin/bash

#regular backup 
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)

#do backup
./../scripts/backup.sh

#drop database
rman target / <<EOF
STARTUP FORCE MOUNT;
ALTER SYSTEM ENABLE RESTRICTED SESSION;
DROP DATABASE NOPROMPT;
quit;
EOF

# Iterate over files in the current directory
con_files=()
for file in $(ls /opt/oracle/homes/OraDB21Home1/dbs/c-*); do
    con_files+=("$file")
done

for index in "${!con_files[@]}"; do
    echo "$index: ${con_files[index]}"
done

read -p "Enter the index of the element you want to access: " index
selection=''
# Validate the index
if [[ $index =~ ^[0-9]+$ && $index -ge 0 && $index -lt ${#con_files[@]} ]]; then
    # Access the element at the specified index
    selection="${con_files[index]}"
else
    echo "Invalid index. Please enter a valid index within the range of the array."
fi
echo $selection

rman target / <<EOF
startup force mount;
restore controlfile from '$selection';
RESTORE DATABASE;
RECOVER DATABASE;
RESTORE DATABASE VALIDATE;
VALIDATE DATABASE;
RECOVER CORRUPTION LIST;
ALTER DATABASE OPEN RESETLOGS;
quit;
EOF
