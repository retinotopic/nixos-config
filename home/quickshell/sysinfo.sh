echo $(sensors | awk '/^edge/ {print substr($2,2)}') #gpu temp
iostat -c | awk 'NR>=4 && NR <=4' | awk '{print $1,$3}' #user cpu,kernel cpu
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
mem_used=$((mem_total - mem_free))
mem_perc=$(awk -v used=$mem_used -v total=$mem_total '
BEGIN {printf "%.1f", used/total*100}')
printf "%.1f %.1f %.1f\n" "$mem_perc" \
    $(bc -l <<< "scale=1; $mem_used/1024/1024") \
    $(bc -l <<< "scale=1; $mem_total/1024/1024")
echo $(sensors | grep 'Tctl' | awk '{print $2}' | head -1) #cpu temp
dysk --ascii -s size-desc --csv -c free -u BINARY
