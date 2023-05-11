terraform {

  backend "s3" {
      bucket = "prefix-fiction"
      key = "sample/terraform-state"
      region = "us-east-1" 
  }
}
