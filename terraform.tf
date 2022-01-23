/*
  Core Terraform configuration
*/
terraform {
  required_version = ">=1.0.0"
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "2.2.1"
    }
  }
}

/*
  PagerDuty REST API Token
  This should be passed through the command line or as an environment variable; DO NOT check this into the repo!

  For example:
  $ terraform apply -var="PAGERDUTY_TOKEN=TOKEN_HERE"

  - or -

  $ export TF_VAR_PAGERDUTY_TOKEN=TOKEN_HERE
  $ terraform apply
*/
provider "pagerduty" {
  token = var.PAGERDUTY_TOKEN
}