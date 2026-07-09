#!/bin/bash


TARGET_URL="https://google.com"
OUTPUT_FILE="https_test_report.txt"

> "$OUTPUT_FILE"

echo "========================================" | tee -a "$OUTPUT_FILE"
echo "HTTPS Test Report" | tee -a "$OUTPUT_FILE"
echo "Target: $TARGET_URL" | tee -a "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"

echo "" | tee -a "$OUTPUT_FILE"
echo "========== 1. HTTPS Request & SSL Certificate Chain ==========" | tee -a "$OUTPUT_FILE"
curl -vI --show-error --trace-time "$TARGET_URL" 2>&1 | tee -a "$OUTPUT_FILE"

echo "" | tee -a "$OUTPUT_FILE"
echo "========== 2. Certificate Chain (via openssl) ==========" | tee -a "$OUTPUT_FILE"
echo | openssl s_client -connect google.com:443 -showcerts 2>/dev/null | tee -a "$OUTPUT_FILE"

echo "" | tee -a "$OUTPUT_FILE"
echo "========== 3. TLS Version Used ==========" | tee -a "$OUTPUT_FILE"
curl -vI --tlsv1.2 --show-error "$TARGET_URL" 2>&1 | grep -i "TLS" | tee -a "$OUTPUT_FILE"

echo "" | tee -a "$OUTPUT_FILE"
echo "========== 4. Certificate Expiration Date ==========" | tee -a "$OUTPUT_FILE"
echo | openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates | tee -a "$OUTPUT_FILE"

echo "" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "Test completed. Report saved in: $OUTPUT_FILE" | tee -a "$OUTPUT_FILE"
