#!/bin/bash

if [ -z "$1" ]; then
    TARGET="127.0.0.1"
    echo "No target specified. Using localhost (127.0.0.1)."
else
    TARGET="$1"
fi

OUTPUT_FILE="telnet_report.txt"

echo "========================================" > $OUTPUT_FILE
echo "Port Connectivity Test via Telnet" >> $OUTPUT_FILE
echo "Target: $TARGET" >> $OUTPUT_FILE
echo "Time: $(date)" >> $OUTPUT_FILE
echo "========================================" >> $OUTPUT_FILE

test_port() {
    PORT=$1
    SERVICE=$2
    echo -n "Testing Port $PORT ($SERVICE)... " >> $OUTPUT_FILE
    
    
    if timeout 3 telnet $TARGET $PORT 2>&1 | grep -q "Connected"; then
        echo "SUCCESS" >> $OUTPUT_FILE
    else
        echo "FAILED" >> $OUTPUT_FILE
    fi
}


test_port 80 "HTTP"
test_port 22 "SSH"
test_port 3306 "MySQL"

echo "========================================" >> $OUTPUT_FILE
echo "Test completed. Results saved in $OUTPUT_FILE" >> $OUTPUT_FILE


cat $OUTPUT_FILE
