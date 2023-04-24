terraform {

  backend "s3" {
      bucket = "prefix-fiction"
      key = "sample/terraform-state"
      region = "us-east-1"
      access_key = "AKIA45KFE7XOQXWBID4B"
      secret_key = "ZoKymJXUdM07xhyOk5mGdSyprij3M50NAHJSZ8c8"
  }
}