#!/bin/bash

# Load the .env file
if [ -f .env ]; then
    export $(cat .env | xargs)
fi



  ./cli/cli.ts  contracts gns publishNewSubgraph \
  --mnemonic "$MNEMONIC" \
  --provider-url "$RPC_ENDPOINT" \
  --ipfs "https://ipfs.network.thegraph.com/" \
  --graphAccount "$ADDRESS" \
  --subgraphDeploymentID "$DEPLOYMENT_ID" \
  --subgraphPath "./subgraphs/$DEPLOYMENT_ID/metadata.json" \
  --versionPath "./subgraphs/$DEPLOYMENT_ID/version-metadata.json"