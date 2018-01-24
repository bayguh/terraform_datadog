# datadog monitorsを管理するterraformコードのテンプレート

terraform version: 0.11.2


## 各環境の構築

1.各環境のterraform.tfstateファイルをGCSで管理します。<br />
  GCSで管理用のバケットを作成し、tasks以下の各環境ディレクトリ以下にある`backend.tf`にパスを記載します。

2.terraformでアクセスするためのサービスアカウント登録してkeyを紐付け、「keys/service_account/access.json」に配置します。

3.プロジェクト毎の設定を`common.tfvars`に記載します。

4.各タスク毎の設定を各環境ディレクトリ以下にある`terraform.tfvars`に記載します。

5.実行はトップにある`terraform_execute.sh`を利用して実行します。

実行例:
```shell
./terraform_execute.sh plan dev
./terraform_execute.sh plan dev upgrade
./terraform_execute.sh apply dev
./terraform_execute.sh destroy dev
```

## 現在のディレクトリ構造
```
├── README.md
├── common.tf
├── common.tfvars
├── keys
│   ├── api_key
│   ├── app_key
│   └─── service_account
│       └── access.json
├── provider.tf
├── tasks
│   ├── dashboards
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── monitors
│       ├── backend.tf
│       ├── main.tf
│       └── terraform.tfvars
└── terraform_execute.sh
```
