#! /bin/bash
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)

start_time=$(date +%s)
#rman target / log=/home/oracle/mybackups/logs/del_obs_bckp.log << EOF
rman target / <<EOF
change archivelog all crosscheck;
delete expired archivelog all;
quit;
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
echo "RMAN-06059 fix in - $h_prt:$m_prt:$s_prt"
