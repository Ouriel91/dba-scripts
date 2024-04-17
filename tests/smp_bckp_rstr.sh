#! /bin/bash

#not nesscary but i do backup
./../scripts/backup.sh

#remove example datafile
rm -rf /opt/oracle/oradata/ORCLCDB/b_test.dbf

#restore database for selected controlfile
./../scripts/restore.sh

sqlplus / as sysdba << EOF
select name from v\$datafile;
exit;
EOF
