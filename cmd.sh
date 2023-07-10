#!/bin/bash

TEMP=`getopt -o c:f:v:h --long contract:,func:,version:,help -- "$@"`
eval set -- "$TEMP"

contract=""
func=""
version=0

contracts=(
    "xudt" "omni" "selection" "checkpoint" "metadata" "stake" "stake-smt"
    "delegate" "delegate-smt" "requirement" "withdraw" "reward"
)

funcs=("gen" "sign" "apply")

usage() {
  echo "Usage: bash $0 -c contract -f function [ -v version ]"
}

function main() {
    while true
    do
        case "$1" in
            -c|--contract) contract=${2}; shift 2 ;;
            -f|--func) func=${2}; shift 2 ;;
            -v|--version) version=${2}; shift 2 ;;
            -h|--help) usage; exit 1 ;;
            --) shift; break ;;
            *)  usage; echo "err"; exit 1 ;;
        esac
    done

    if [[ ! "${contracts[@]}" =~ "${contract}" ]]; then
        echo "${contract} is invalidd"
        exit 1
    fi

    if [[ ! "${funcs[@]}" =~ "${func}" ]]; then
        echo "${func} is invalid"
        exit 1
    fi

    info=${contract}
    if [ ${version} -gt 0 ]; then
        info="${info}${version}"
    fi

    case "${func}" in
        gen) ckb-cli deploy gen-txs --deployment-config ./deploy/${contract}.toml --migration-dir ./migrations/${contract} --from-address ckt1qzda0cr08m85hc8jlnfp3zer7xulejywt49kt2rr0vthywaa50xwsqdwcq424yk63qsagvnspjmtuukh4zt3j9cdgn4kv --info-file ./deploy/infos/${info}.json --sign-now; ;;
        sign) ckb-cli deploy sign-txs --from-account ckt1qzda0cr08m85hc8jlnfp3zer7xulejywt49kt2rr0vthywaa50xwsqdwcq424yk63qsagvnspjmtuukh4zt3j9cdgn4kv --info-file ./deploy/infos/${info}.json --add-signatures; ;;
        apply) ckb-cli deploy apply-txs --info-file ./deploy/infos/${info}.json --migration-dir ./migrations/stake; ;;
        *) echo "internal error"; exit 1 ;;
    esac
}

main $@
