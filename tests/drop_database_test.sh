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

