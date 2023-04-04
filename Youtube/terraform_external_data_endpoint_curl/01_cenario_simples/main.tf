provider "external" {
  # Configuration options
}

data "external" "curl_tests" {
  program = ["bash", "${path.root}/endpoint_curl.sh"]
}

output "curl_tests_result" {
  value = data.external.curl_tests.result
}
