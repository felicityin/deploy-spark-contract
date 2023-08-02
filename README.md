# Run a CKB dev Blockchain

Reference: [Run a CKB Dev Blockchain](https://docs.nervos.org/docs/basics/guides/devchain)

1. Download the Latest [CKB Binary](https://github.com/nervosnetwork/ckb/releases/tag/v0.111.0-rc8).

2. Import your account into ckb-cli.

   ```
   echo 33b08bb054d5dd04013156dced8ba2ce4d8cc5973e10d905a228ea1abc267e60 >> privkey
   ckb-cli account import --privkey-path privkey
   ```

3. Start the CKB dev Blockchain.

   ```
   cd dev-chain
   
   // start the ckb node
   ckb run
   
   // start the ckb miner
   ckb miner
   ```

# Compile Contracts

Reference: [axon-contract readme](https://github.com/axonweb3/axon-contract/tree/main)

Compile axon contracts.

```
git clone https://github.com/axonweb3/axon-contract
cd axon-contract

capsule build --release

cp axon-contract/build/release/* deploy-spark-contract/bin/
```

Other contracts.

```
git clone https://github.com/nervosnetwork/ckb-production-scripts

cd ckb-production-scripts
make all-via-docker 

cp ckb-production-scripts/build/omni_lock deploy-spark-contract/bin/
cp ckb-production-scripts/build/xudt_rce deploy-spark-contract/bin/
cp ckb-production-scripts/build/always_success deploy-spark-contract/bin/
```

# Switch network

```
ckb-cli
config --url http://127.0.0.1:8114
```

# Deploy Contracts

Reference: [How to use ckb-cli to deploy a contract](https://github.com/nervosnetwork/ckb-cli/wiki/Deploy-contracts#generate-the-update-transaction)

Create migration directories.
```
bash create-migrations.sh
```

Taking deploying contract `stake` as an example.

```
bash cmd.sh -c stake -f g

bash cmd.sh -c stake -f s

bash cmd.sh -c stake -f a
```

# Upgrade Contracts

Taking upgrading contract `stake` as an example.

```
bash cmd.sh -c stake -f g -v 1

bash cmd.sh -c stake -f s -v 1

bash cmd.sh -c stake -f a -v 1
```
