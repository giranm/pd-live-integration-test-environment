/*
  Project Variables
*/

# PagerDuty API Token
variable "PAGERDUTY_TOKEN" {
  type = string
}

# ServiceNow Instance Details
variable "SERVICENOW_TARGET_URL" {
  type = string
}

variable "SERVICENOW_USER" {
  type = string
}

variable "SERVICENOW_PASSWORD" {
  type = string
}

# Custom Incident Action
variable "CUSTOM_INCIDENT_ACTION_URL" {
  type = string
}