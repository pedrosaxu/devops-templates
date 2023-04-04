output "curl_tests_result" {
  value = values(data.external.curl_tests).*.result
}
