#!/bin/bash
# Azure P2S VPN Client Certificate Generator
# Day 1 - 24-06-2026  🚀
# WARNING: Never commit .key or .pfx files to GitHub

echo "=== Azure P2S VPN Client Cert Generator ==="

# Safety check
if [ -f ".git" ]; then
    echo "⚠️  WARNING: Running in git repo. Make sure .gitignore has *.key *.pfx"
fi

# Step 1: Generate Private Key
openssl genrsa -out .key 2048
echo "✅ Private key generated - DO NOT COMMIT THIS"

# Step 2: Generate Certificate Signing Request  
openssl req -new -key .key -out VivekClient.csr -subj "/CN=VivekClient"
echo "✅ CSR generated"

# Step 3: Sign with Root CA - Replace with your Root cert files
openssl x509 -req -in VivekClient.csr -CA VivekRootCert.cer -CAkey VivekRootKey.key -CAcreateserial -out VivekClient.cer -days 365 -sha256
echo "✅ Client cert signed by Root CA"

# Step 4: Export to PFX for Windows import
echo "Set PFX Export Password:"
openssl pkcs12 -export -out .pfx -inkey .key -in VivekClient.cer -certfile VivekRootCert.cer

# Cleanup sensitive files
rm VivekClient.csr
echo ""
echo "🔥 DONE: Import .pfx to connect VPN"
echo "🔒 SECURITY: Add these to .gitignore: *.key *.pfx *.p12"
echo "🔒 SECURITY: Delete .key and .pfx after use"
echo "Error 798 = Client cert missing. This script fixes it."
