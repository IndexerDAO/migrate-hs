# Migrate HS Subgraph

### Install IPFS

https://docs.ipfs.tech/install/command-line/#install-official-binary-distributions

### Run IPFS daemon service
```bash
cat <<EOF | sudo tee /etc/systemd/system/ipfs.service
[Unit]
Description=InterPlanetary File System (IPFS) daemon
After=network.target

[Service]
User=root
ExecStart=/usr/local/bin/ipfs daemon
Restart=on-failure
Environment="IPFS_PATH=/root/.ipfs"

[Install]
WantedBy=multi-user.target
EOF
```
```bash
sudo systemctl start ipfs.service && sudo systemctl enable ipfs.service
```
### Create Subgraph Directory in ~/migrate-hs/contracts-dev/cli/subgraphs/Qmxxxxxxxxxx
```bash
sudo mkdir contracts-dev/cli/subgraphs/QmPfXMydP7R1XzCbDPgpJ7fh5h22HsNAxVb1RgA9XvwJaj # HS Deployment ID
```
### Add metadata.json, version-metdata.json and png. 

```bash
e.g. contracts-dev/cli/subgraphs/QmPfXMydP7R1XzCbDPgpJ7fh5h22HsNAxVb1RgA9XvwJaj
```
### Pin Logo
```bash
cd contracts-dev/cli/subgraphs/QmPfXMydP7R1XzCbDPgpJ7fh5h22HsNAxVb1RgA9XvwJaj
curl -s -F "file=@./quickswap_polygon.png" "http://localhost:5001/api/v0/add" | jq -r '.Hash'
#Save the Output for next command
```
### Pin Logo to IPFS Hash
```bash
curl -X --POST https://ipfs.network.thegraph.com/api/v0/pin/add?arg=/ipfs/Qmhash-output-from-above-command
```
### Pin files to IPFS
```bash
./pin_subgraph_files.sh QmPfXMydP7R1XzCbDPgpJ7fh5h22HsNAxVb1RgA9XvwJaj hs-network migrated-network
```

### Build

```bash
cd ~/contracts-dev && yarn && yarn build
```

### Edit .env
```bash
MNEMONIC="the quick brown fox jumped over the lazy dog" # Mneumonic to funded wallet
RPC_ENDPOINT=https://ethereum.publicnode.com # RPC endpoint
ADDRESS=0xdeadbeef12345678901234567890 # Address of wallet
DEPLOYMENT_ID=QmQN451jswE4LSSp7fLdQzP86XxY4Hc5UrrGRRp1Nuk2d1 # Deployment ID on HS
```

### Run
```bash
cd ~/migrate-hs && chmod +x publish.sh && ./publish.sh
```
