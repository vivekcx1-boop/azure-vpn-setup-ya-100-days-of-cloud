#!/bin/bash
# Azure P2S VPN Client Certificate Generator
# Day 1 - 24-06-2026  🚀

echo "=== Azure P2S VPN Client Cert Generator ==="

# Step 1: Generate Private Key
openssl genrsa -out VivekClient.key 2048
echo "✅ Private key generated"

# Step 2: Generate Certificate Signing Request  
openssl req -new -key VivekClient.key -out VivekClient.csr -subj "/CN=VivekClient"
echo "✅ CSR generated"

# Step 3: Sign with Root CA - Replace with your Root cert files
openssl x509 -req -in VivekClient.csr -CA VivekRootCert.cer -CAkey VivekRootKey.key -CAcreateserial -out VivekClient.cer -days 365 -sha256
echo "✅ Client cert signed by Root CA"

# Step 4: Export to PFX for Windows import
echo "Set PFX Export Password:"
openssl pkcs12 -export -out VivekClient.pfx -inkey VivekClient.key -in VivekClient.cer -certfile VivekRootCert.cer

echo "🔥 DONE: Import VivekClient.pfx to connect VPN"
echo "Error 798 = Client cert missing. This script fixes it."
