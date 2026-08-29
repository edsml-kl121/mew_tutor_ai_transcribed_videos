#!/usr/bin/env bash
# Config for the Azure Speech Fast Transcription pipeline.
# Edit these if the Speech resource, subscription, or network setup changes.

# Azure AI Foundry Speech resource (kind: AIServices) sitting inside the spoke VNet
SPEECH_RESOURCE_NAME="foundry-app-seaozewfizfnaft4"
SPEECH_RESOURCE_HOST="foundry-app-seaozewfizfnaft4.cognitiveservices.azure.com"
SPEECH_RESOURCE_RG="rg-ai-dev-sea"
SUBSCRIPTION_ID="d88c020a-2180-43da-91a2-f6cc01f25946"

# Private endpoint IP for the Speech resource. There is no private DNS zone
# wired up for this resource, so normal DNS resolution falls through to the
# public internet (which is blocked). We force the connection to this IP via
# curl --resolve instead. Run ./refresh_ip.sh if this ever stops working
# (e.g. the private endpoint NIC was recreated).
SPEECH_PRIVATE_IP="10.10.6.7"

# Fast Transcription API version (synchronous, direct file upload, no blob
# storage required — see CLAUDE.md for why this API was chosen over batch
# transcription).
API_VERSION="2024-11-15"

# Candidate locales for automatic language identification. Add/remove as
# needed for the languages your videos are actually in.
CANDIDATE_LOCALES='["en-US","th-TH"]'

# Fast Transcription API hard limits (as of this writing): 250 MB, 2 hours.
MAX_SIZE_BYTES=$((250 * 1024 * 1024))
