#! /bin/bash
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)
start_time=$(date +%s)

rman target sys/mypass@ORCLCDB log=/home/oracle/mybackups/logs/bckp_inc.log << EOF
run
{
allocate channel ch1 device type disk;
allocate channel ch2 device type disk;
allocate channel ch3 device type disk;
allocate channel ch4 device type disk;
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/home/oracle/mybackups/inc0_%u';
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 4;
BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG TAG=MY_BACKUP_0;
release channel ch1;
release channel ch2;
release channel ch3;
release channel ch4;
}
EOF

# End measuring time
end_time=$(date +%s)

# Calculate elapsed time
elapsed_time=$((end_time - start_time))

# Convert elapsed time to hours, minutes, and seconds
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

h_prt=''
m_prt=''
s_prt=''

if [ $hours -lt 10 ]; then
h_prt="0$hours"
else
h_prt="$hours"
fi

if [ $minutes -lt 10 ]; then
m_prt="0$minutes"
else
m_prt="$minutes"
fi

if [ $seconds -lt 10 ]; then
s_prt="0$seconds"
else
s_prt="$seconds"
fi

# Print the elapsed time
echo "RMAN incremantal backup 0 completed in - $h_prt:$m_prt:$s_prt"
