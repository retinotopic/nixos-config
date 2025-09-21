nmcli -t -f SSID,ACTIVE,BSSID,SIGNAL,BARS,SECURITY device wifi list | while IFS=: read -r ssid bssid active signal bars sec; do
    if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then
        echo "$bssid:$ssid:$active:$signal:$bars:$sec:true"
    else
        echo "$bssid:$ssid:$active:$signal:$bars:$sec:false"
    fi
done
nmcli connection show "TP-Link_776C_5G"
