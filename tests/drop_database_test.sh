#! /bin/bash

#regular backup 
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)

#do backup
#./../scripts/backup.sh

#drop database
#rman target / <<EOF
#STARTUP FORCE MOUNT;
#ALTER SYSTEM ENABLE RESTRICTED SESSION;
#DROP DATABASE NOPROMPT;
#quit;
#EOF

selection=''
con_files=()
for file in $(ls /opt/oracle/homes/OraDB21Home1/dbs/c-*); do
    con_files+=("$file")
done

selection=${con_files[-1]}

rman target / <<EOF
startup force mount;
quit;
EOF

rman target / <<EOF
restore controlfile from '$selection';
RESTORE DATABASE;
RECOVER DATABASE;
RESTORE DATABASE VALIDATE;
VALIDATE DATABASE;
RECOVER CORRUPTION LIST;
ALTER DATABASE OPEN; 
quit;
EOF
