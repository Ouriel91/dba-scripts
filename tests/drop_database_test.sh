#! /bin/bash

#regular backup 
./../scripts/backup.sh

#drop database
rman target / <<EOF
DROP DATABASE;
quit;
EOF

sqlplus / as sysdba << EOF
shutdown immediate;
startup nomount;
exit;
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

rman target / <<EOF
restore controlfile from '/opt/oracle/homes/OraDB21Home1/dbs/$selection';
ALTER DATABASE MOUNT;
RESTORE DATABASE;
RECOVER DATABASE;
ALTER DATABASE OPEN;
quit;
EOF
