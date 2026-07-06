#!/bin/bash


OUTPUT_FILE="report_connectivity"


> "$OUTPUT_FILE"


echo "========================================" >> "$OUTPUT_FILE"
echo "Ping to 8.8.8.8 (5 packets):" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
ping -c 5 8.8.8.8 >> "$OUTPUT_FILE" 2>&1


echo "" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
echo "Ping to google.com (5 packets):" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
ping -c 5 google.com >> "$OUTPUT_FILE" 2>&1


echo "" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
echo "DNS resolution for github.com:" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
nslookup github.com >> "$OUTPUT_FILE" 2>&1


echo "" >> "$OUTPUT_FILE"
echo "========================================" >> "$OUTPUT_FILE"
echo "Test completed. Results saved in $OUTPUT_FILE" >> "$OUTPUT_FILE"
