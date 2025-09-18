sensors | awk '/^edge/ {print substr($2,2)}' #gpu temp

iostat -c | awk 'NR==4' | awk '{print $1,$3}' #user cpu,kernel cpu

free -h -L | grep -o "MemUse.*" | awk '{print $2}' #mem usage

sensors | grep 'Tctl' | awk '{print $2}' #cpu temp
dysk --ascii -s size-desc --csv -c free -u BINARY | awk 'NR==2'
