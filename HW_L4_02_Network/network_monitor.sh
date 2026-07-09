#!/bin/bash

LOG_FILE="monitoring_log.txt"


wlp3s0f0="wlp3s0f0"

> "$LOG_FILE"

get_interface_stats() {
    cat /proc/net/dev | grep "$INTERFACE" | awk '{print $2, $10}'
}

calculate_bandwidth() {
    local rx1=$1
    local tx1=$2
    local rx2=$3
    local tx2=$4

    local rx_diff=$((rx2 - rx1))
    local tx_diff=$((tx2 - tx1))

    local rx_bps=$((rx_diff / 5))
    local tx_bps=$((tx_diff / 5))

    local rx_kbps=$((rx_bps / 1024))
    local tx_kbps=$((tx_bps / 1024))

    echo "Download: ${rx_kbps} KB/s | Upload: ${tx_kbps} KB/s"
}


count_active_connections() {
    ss -tun | grep -E 'ESTAB|SYN-SENT|SYN-RECV|FIN-WAIT|TIME-WAIT|CLOSE-WAIT|LAST-ACK' | wc -l
}


top_5_ips() {

    ss -tun | awk '{print $5}' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | sort -nr | head -5
}


while true; do
    # دریافت زمان فعلی
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    read rx1 tx1 <<< $(get_interface_stats)

    sleep 5

    read rx2 tx2 <<< $(get_interface_stats)

    BANDWIDTH=$(calculate_bandwidth "$rx1" "$tx1" "$rx2" "$tx2")

    CONNECTIONS=$(count_active_connections)

    TOP_IPS=$(top_5_ips)

    {
        echo "========================================"
        echo "Time: $TIMESTAMP"
        echo "Interface: $INTERFACE"
        echo "Bandwidth Usage: $BANDWIDTH"
        echo "Active Connections: $CONNECTIONS"
        echo "Top 5 IP Addresses (by traffic):"
        echo "$TOP_IPS"
        echo "========================================"
        echo ""
    } >> "$LOG_FILE"

    echo "Logged at $TIMESTAMP"

done
