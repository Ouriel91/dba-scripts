#! /bin/bash

#regular backup 
./../scripts/backup.sh

#incremental backup level 0
./../scripts/backup_inc_0.sh

sqlplus / as sysdba << EOF
create table myid(id number);
insert into myid(id) select round(dbms_random.value(1,100)) as random_number from dual connect by level <=100;
commit;
select count(*) from myid;
exit;
EOF

#incremental backup level 1
./../scripts/backup_inc_1.sh

sqlplus / as sysdba << EOF
insert into myid(id) select round(dbms_random.value(1,100)) as random_number from dual connect by level <=100;
commit;
select count(*) from myid;
drop table myid;
exit;
EOF

./../scripts/backup_inc_1_cum.sh

rman target / <<EOF
list backup summary;
quit;
EOF
