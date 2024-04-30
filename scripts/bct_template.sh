#! /bin/bash

sqlplus / as sysdba << EOF
ALTER DATABASE ENABLE BLOCK CHANGE TRACKING;
SHOW PARAMETER DB_CREATE_FILE_DEST;
select filename,status from V\$block_change_tracking;
select * from v\$sgastat where name like '%CTWR%';
alter database disable block change tracking;
Select filename,status from V\$block_change_tracking;
select * from v\$sgastat where name like '%CTWR%';
exit;
EOF
