#! /bin/bash

#that is sample file - grab scn by yourself only
start_time=$(date +%s)

echo "Enter scn for incomplete restore: "
read selected_scn
rman target /  log=/home/oracle/mybackups/logs/rstr_until.log << EOF
shutdown immediate;
startup mount;
run
{
set until scn $selected_scn;
restore database;
recover database;
}
alter database open resetlogs;
exit;
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
echo "RMAN incomplete restore completed in - $h_prt:$m_prt:$s_prt"
