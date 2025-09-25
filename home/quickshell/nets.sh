nmcli -t -f SSID,ACTIVE,BARS,SECURITY device wifi list \
--rescan yes | while IFS=: read -r ssid active bars sec; do
    if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then
        echo "$ssid:$active:$bars:$sec:true"
    else
        echo "$ssid:$active:$bars:$sec:false"
    fi
done
