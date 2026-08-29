#!/usr/bin/env bash
# Re-resolves the Speech resource's private endpoint IP and updates config.sh.
# Run this if transcribe.sh starts failing to connect (curl: (28) Connection
# timed out) even with VPN connected — the private endpoint NIC may have
# been recreated with a new IP.
set -euo pipefail
cd "$(dirname "$0")"
source ./config.sh

echo "Looking up private endpoint NIC for $SPEECH_RESOURCE_NAME..."
NIC_ID=$(az network private-endpoint list \
  --resource-group "$SPEECH_RESOURCE_RG" \
  --query "[?contains(name,'$SPEECH_RESOURCE_NAME')].networkInterfaces[0].id | [0]" \
  -o tsv)

if [ -z "$NIC_ID" ]; then
  echo "Could not find a private endpoint for $SPEECH_RESOURCE_NAME in $SPEECH_RESOURCE_RG." >&2
  echo "Check the resource/RG names in config.sh, or that you're logged into the right subscription (az account show)." >&2
  exit 1
fi

NEW_IP=$(az network nic show --ids "$NIC_ID" --query "ipConfigurations[0].privateIPAddress" -o tsv)

if [ -z "$NEW_IP" ]; then
  echo "Found the NIC but couldn't read its private IP." >&2
  exit 1
fi

echo "Resolved IP: $NEW_IP (was: $SPEECH_PRIVATE_IP)"
sed -i '' "s/^SPEECH_PRIVATE_IP=.*/SPEECH_PRIVATE_IP=\"$NEW_IP\"/" ./config.sh
echo "Updated config.sh."
