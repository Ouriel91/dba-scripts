#! /bin/bash

#regular backup 
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)

#find the last backup of controlfile that made before database drop
selection=''
con_files=()
for file in $(ls /opt/oracle/homes/OraDB21Home1/dbs/c-*); do
    con_files+=("$file")
done

selection=${con_files[-1]}

#mount database, restore + recover + validation and open database
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
