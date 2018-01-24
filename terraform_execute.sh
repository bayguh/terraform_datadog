#!/bin/sh

_usage() {
    echo "terraform_execute.sh <command> <task> (upgrade)"
    _command
    _task
}

_command() {
    echo "command=plan|apply|destroy|graph|..."
}

_task() {
    echo "task=tasks以下のディレクトリ名を指定"
}

_execute() {
    # 実行ディレクトリ移動
    cd tasks/${TASK}/

    # provider.tf, common.tfをシンボリック化
    ln -s ../../provider.tf ./
    ln -s ../../common.tf ./

    # stateファイル初期化
    if [[ $UPGRADE == "upgrade" ]]; then
        terraform init -upgrade
    else
        terraform init
    fi

    # 実行
    if [ $COMMAND == "graph" ]; then
        terraform ${COMMAND} | dot -Tpng > "${TASK}-graph.png"
    else
        terraform ${COMMAND} -var datadog_api_key_path="../../keys/api_key" -var datadog_app_key_path="../../keys/app_key" -var-file="../../common.tfvars"
    fi

    # シンボリックリンク解除
    unlink provider.tf
    unlink common.tf
}

if [ $# -ne 2 ] && [ $# -ne 3 ]; then
    _usage
    exit 1
fi

if [ ! -d ./tasks/${2} ]; then
    echo "指定したtaskはありません."
    exit 1
fi

COMMAND=$1
TASK=$2
UPGRADE=$3

_execute
