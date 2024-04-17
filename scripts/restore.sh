#! /bin/bash
export ORACLE_SID=ORCLCDB
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1
export DATE=$(date +%y-%m-%d_%H%M%S)

# Iterate over files in the current directory
con_files=()
for file in $(ls /opt/oracle/homes/OraDB21Home1/dbs/c-*); do
    con_files+=("$file")
done

for index in "${!con_files[@]}"; do
    echo "$index: ${con_files[index]}"
done

read -p "Enter the index of the element you want to access: " index
selection=''
# Validate the index
if [[ $index =~ ^[0-9]+$ && $index -ge 0 && $index -lt ${#con_files[@]} ]]; then
    # Access the element at the specified index
    selection="${con_files[index]}"
else
    echo "Invalid index. Please enter a valid index within the range of the array."
fi

start_time=$(date +%s)
rman target / log=/home/oracle/mybackups/logs/rstr.log << EOF
rman target / <<EOF
shutdown abort;
startup nomount;
restore controlfile from '/opt/oracle/homes/OraDB21Home1/dbs/$selection';
ALTER DATABASE MOUNT;
RESTORE DATABASE;
RECOVER DATABASE;
alter database open resetlogs;
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
echo "RMAN restore completed in - $h_prt:$m_prt:$s_prt"
