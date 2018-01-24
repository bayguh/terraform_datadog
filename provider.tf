/**
 * プロバイダー設定
 * https://www.terraform.io/docs/providers/datadog/index.html
 */
provider "datadog" {
  api_key = "${chomp(file(var.datadog_api_key_path))}"
  app_key = "${chomp(file(var.datadog_app_key_path))}"
}
