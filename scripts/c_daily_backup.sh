#! /bin/bash
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)
rman target sys/mypass@ORCLCDB log=/home/oracle/mybackups/logs/bckp.log << EOF
run
{
allocate channel ch1 device type disk;
allocate channel ch2 device type disk;
allocate channel ch3 device type disk;
allocate channel ch4 device type disk;
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/home/oracle/mybackups/full_%u';
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 4;
BACKUP AS COMPRESSED BACKUPSET DATABASE PLUS ARCHIVELOG TAG=MY_BACKUP;
release channel ch1;
release channel ch2;
release channel ch3;
release channel ch4;
}
EOF
