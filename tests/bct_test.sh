#! /bin/bash

#backup incremental 0&1 without bct
./../scripts/backup_inc_0.sh
./../scripts/backup_inc_1.sh

#backup incremental 0&1 with bct
sqlplus / as sysdba << EOF
ALTER DATABASE ENABLE BLOCK CHANGE TRACKING;
SHOW PARAMETER DB_CREATE_FILE_DEST;
select filename,status from V\$block_change_tracking;
select * from v\$sgastat where name like '%CTWR%';
exit;
EOF
./../scripts/backup_inc_0.sh
./../scripts/backup_inc_1.sh

#disable bct
sqlplus / as sysdba << EOF
alter database disable block change tracking;
Select filename,status from V\$block_change_tracking;
select * from v\$sgastat where name like '%CTWR%';
exit;
EOF
