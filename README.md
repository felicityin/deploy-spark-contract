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

capsule build -n checkpoint --release
capsule build -n metadata --release
capsule build -n stake --release
capsule build -n stake-smt --release
capsule build -n delegate --release
capsule build -n delegate-smt --release
capsule build -n requirement --release
capsule build -n withdraw --release
capsule build -n reward --release
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

Then copy compiled contracts from `axon-contract/build/release` to `./bin`.

# Switch network

```
ckb-cli
config --url http://127.0.0.1:8114
```

# Deploy Contracts

Reference: [How to use ckb-cli to deploy a contract](https://github.com/nervosnetwork/ckb-cli/wiki/Deploy-contracts#generate-the-update-transaction)

Taking deploying contract `stake` as an example.

```
cd deploy-spark-contract
mkdir -p deploy/infos
mkdir -p migrations/stake
```

or just run bash:
```
bash create-migrations.sh
```

```
ckb-cli deploy gen-txs --deployment-config ./deploy/stake.toml --migration-dir ./migrations/stake --from-address ckt1qzda0cr08m85hc8jlnfp3zer7xulejywt49kt2rr0vthywaa50xwsqdwcq424yk63qsagvnspjmtuukh4zt3j9cdgn4kv --info-file ./deploy/infos/stake.json --sign-now

ckb-cli deploy sign-txs --from-account ckt1qzda0cr08m85hc8jlnfp3zer7xulejywt49kt2rr0vthywaa50xwsqdwcq424yk63qsagvnspjmtuukh4zt3j9cdgn4kv --info-file ./deploy/infos/stake.json --add-signatures

ckb-cli deploy apply-txs --info-file ./deploy/infos/stake.json --migration-dir ./migrations/stake
```

Or use bash as follows.

```
bash cmd.sh -c stake -f g

bash cmd.sh -c stake -f s

bash cmd.sh -c stake -f a
```

# Upgrade Contracts

Taking upgrading contract `stake` as an example.

```
ckb-cli deploy gen-txs --deployment-config ./deploy/stake.toml --migration-dir ./migrations/stake --from-address ckt1qzda0cr08m85hc8jlnfp3zer7xulejywt49kt2rr0vthywaa50xwsqdwcq424yk63qsagvnspjmtuukh4zt3j9cdgn4kv --info-file ./deploy/infos/stake1.json --sign-now

ckb-cli deploy sign-txs --from-account ckt1qzda0cr08m85hc8jlnfp3zer7xulejywt49kt2rr0vthywaa50xwsqdwcq424yk63qsagvnspjmtuukh4zt3j9cdgn4kv --info-file ./deploy/infos/stake1.json --add-signatures

ckb-cli deploy apply-txs --info-file ./deploy/infos/stake1.json --migration-dir ./migrations/stake
```

Or use bash as follows.

```
bash cmd.sh -c stake -f g -v 1

bash cmd.sh -c stake -f s -v 1

bash cmd.sh -c stake -f a -v 1
```
