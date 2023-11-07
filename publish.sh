#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    while IFS= read -r line; do
        # Skip empty lines and lines starting with #
        if [[ -z "$line" || "$line" =~ ^# ]]; then
            continue
        fi
        # Use eval to handle the quotes correctly
        eval "export $line"
    done < .env
fi

# Change to the contracts-dev directory
cd "$HOME/migrate-hs/contracts-dev"

# Execute the TypeScript CLI command
./cli/cli.ts  contracts gns publishNewSubgraph \
  --mnemonic "$MNEMONIC" \
  --provider-url "$RPC_ENDPOINT" \
  --ipfs "https://ipfs.network.thegraph.com/" \
  --graphAccount "$ADDRESS" \
  --subgraphDeploymentID "$DEPLOYMENT_ID" \
  --subgraphPath "./subgraphs/$DEPLOYMENT_ID/metadata.json" \
  --versionPath "./subgraphs/$DEPLOYMENT_ID/version-metadata.json"
