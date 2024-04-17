#! /bin/bash

#create table
sqlplus / as sysdba << EOF
create table try_tb as select * from all_tables;
select count(*) from try_tb;
exit;
EOF

#backup database + archive logs
./../scripts/backup.sh

#grab backup scn
backup_scn=$(sqlplus -s / as sysdba <<END
set head off
set feedback off
set pagesize 2400
set linesize 2048
select CURRENT_SCN from v\$database;
exit;
END
)

echo $backup_scn

#test for later restore - grab scn/time/both for later
sqlplus / as sysdba << EOF
delete from try_tb where rownum<=1000;
commit;
select count(*) from try_tb;
exit;
EOF

#change to scn that we get before delete
rman target /  log=/home/oracle/mybackups/logs/rstr_until.log << EOF
shutdown immediate;
startup mount;
run
{
set until scn $backup_scn;
restore database;
recover database;
}
alter database open resetlogs;
exit;
EOF

sqlplus / as sysdba << EOF
select count(*) from try_tb;
exit;
EOF
