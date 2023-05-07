terraform {

  backend "s3" {
      bucket = "prefix-fiction"
      key = "sample/terraform-state"
      region = "us-east-1"
      access_key = "AKIA45KFE7XOWD4A3MWH"
      secret_key = "Jgq7au3arYp6PP3iyNiHte9aYeLv4LjqgLDASnQK"
  }
}
