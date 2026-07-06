#!/bin/bash


# ============================================

if [ -z "$1" ]; then
    echo "Usage: $0 <Server_IP>"
    echo "Example: $0 192.168.1.10"
    echo ""
    echo "Note: The server must have iperf3 running in server mode:"
    echo "  iperf3 -s"
    exit 1
fi

SERVER_IP=$1
OUTPUT_FILE="report_performance.txt"

> "$OUTPUT_FILE"


if ! command -v iperf3 &> /dev/null; then
    echo "iperf3 not found. Installing..." | tee -a "$OUTPUT_FILE"
    sudo apt update && sudo apt install iperf3 -y
fi

echo "========================================" | tee -a "$OUTPUT_FILE"echo "Network Performance Test Report" | tee -a "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "Target Server: $SERVER_IP" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"


# --------------------------------------------
echo "" | tee -a "$OUTPUT_FILE"
echo "========== 1. Latency (Ping RTT) ==========" | tee -a "$OUTPUT_FILE"
ping -c 10 "$SERVER_IP" | tee -a "$OUTPUT_FILE"

# --------------------------------------------
echo "" | tee -a "$OUTPUT_FILE"
echo "========== 2. Bandwidth, Jitter & Packet Loss (iperf3 UDP) ==========" | tee -a "$OUTPUT_FILE"
echo "Testing with UDP mode (10 seconds, 10 Mbps bandwidth)..." | tee -a "$OUTPUT_FILE"
iperf3 -c "$SERVER_IP" -u -b 10M -t 10 | tee -a "$OUTPUT_FILE"


# --------------------------------------------
echo "" | tee -a "$OUTPUT_FILE"
echo "========== 3. Bandwidth (iperf3 TCP) ==========" | tee -a "$OUTPUT_FILE"
echo "Testing with TCP mode (10 seconds)..." | tee -a "$OUTPUT_FILE"
iperf3 -c "$SERVER_IP" -t 10 | tee -a "$OUTPUT_FILE"


echo "" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "Test completed. Full report saved in: $OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
