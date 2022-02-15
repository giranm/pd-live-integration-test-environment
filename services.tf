locals {
  business_services = {
    "business_service_a" = {
      name             = "Business Service A"
      description      = "Business Service A"
      point_of_contact = "Team A"
      team             = pagerduty_team.team_a.id
    }
    "business_service_b" = {
      name             = "Business Service B"
      description      = "Business Service B"
      point_of_contact = "Team B"
      team             = pagerduty_team.team_b.id
    }
    "business_service_c" = {
      name             = "Business Service C"
      description      = "Business Service C"
      point_of_contact = "Team C"
      team             = pagerduty_team.team_c.id
    }
  }
  services = {
    "service_a1" = {
      name              = "Service A1"
      escalation_policy = pagerduty_escalation_policy.escalation_policies["team_a"].id
      parent_service    = pagerduty_business_service.business_services["business_service_a"].id
    }
    "service_a2" = {
      name              = "Service A2"
      escalation_policy = pagerduty_escalation_policy.escalation_policies["team_a"].id
      parent_service    = pagerduty_business_service.business_services["business_service_a"].id
    }
    "service_b1" = {
      name              = "Service B1"
      escalation_policy = pagerduty_escalation_policy.escalation_policies["team_b"].id
      parent_service    = pagerduty_business_service.business_services["business_service_b"].id
    }
    "service_b2" = {
      name              = "Service B2"
      escalation_policy = pagerduty_escalation_policy.escalation_policies["team_b"].id
      parent_service    = pagerduty_business_service.business_services["business_service_b"].id
    }
    "service_c1" = {
      name              = "Service C1"
      escalation_policy = pagerduty_escalation_policy.escalation_policies["team_c"].id
      parent_service    = pagerduty_business_service.business_services["business_service_c"].id
    }
    "service_c2" = {
      name              = "Service C2"
      escalation_policy = pagerduty_escalation_policy.escalation_policies["team_c"].id
      parent_service    = pagerduty_business_service.business_services["business_service_c"].id
    }
  }
}

resource "pagerduty_business_service" "business_services" {
  for_each         = local.business_services
  name             = each.value.name
  description      = each.value.description
  point_of_contact = each.value.point_of_contact
  team             = each.value.team
}

resource "pagerduty_service" "services" {
  for_each                = local.services
  name                    = each.value.name
  auto_resolve_timeout    = 3600
  acknowledgement_timeout = "null"
  escalation_policy       = each.value.escalation_policy
  alert_creation          = "create_alerts_and_incidents"
  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
  alert_grouping_parameters {
    type = "intelligent"
  }
}

resource "pagerduty_service_dependency" "service_dependencies" {
  for_each = local.services
  dependency {
    dependent_service {
      id   = each.value.parent_service
      type = "business_service"
    }
    supporting_service {
      id   = pagerduty_service.services[each.key].id
      type = "service"
    }
  }
}

resource "pagerduty_service_integration" "service_integrations" {
  for_each = local.services
  name     = "API V2"
  type     = "events_api_v2_inbound_integration"
  service  = pagerduty_service.services[each.key].id
}

resource "pagerduty_extension_servicenow" "servicenow_extension" {
  for_each          = local.services
  name              = "ServiceNow"
  extension_schema  = data.pagerduty_extension_schema.servicenow_webhook.id
  extension_objects = [pagerduty_service.services[each.key].id]
  target            = var.SERVICENOW_TARGET_URL
  snow_user         = var.SERVICENOW_USER
  snow_password     = var.SERVICENOW_PASSWORD
  sync_options      = "manual_sync"
  task_type         = "incident"
  referer           = "None"
}
