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

### Build

```bash
cd ~/migrate-hs/contracts-dev && yarn && yarn build
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
