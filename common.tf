# 実行時に変数指定----------------------------
variable "datadog_api_key_path" {
  type        = "string"
  description = "api_keyへのpath"
}

variable "datadog_app_key_path" {
  type        = "string"
  description = "app_keyへのpath"
}
# -----------------------------------------

/**
 * terraform対応バージョン
 * https://www.terraform.io/docs/configuration/terraform.html
 */
terraform {
  required_version = "= 0.11.2"
}
