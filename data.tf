/*
  Shared Data Sources
*/

data "pagerduty_extension_schema" "servicenow_webhook" {
  name = "ServiceNow (v7)"
}

data "pagerduty_extension_schema" "custom_incident_action" {
  name    = "Custom Incident Action"
}