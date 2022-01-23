locals {
  escalation_policies = {
    "team_a" = {
      name = "Team A (EP)"
      team = pagerduty_team.team_a.id
      primary_schedule = pagerduty_schedule.schedules["team_a_primary"].id
      secondary_schedule = pagerduty_schedule.schedules["team_a_secondary"].id
      manager_schedule = pagerduty_schedule.schedules["team_a_manager"].id
    }
    "team_b" = {
      name = "Team B (EP)"
      team = pagerduty_team.team_b.id
      primary_schedule = pagerduty_schedule.schedules["team_b_primary"].id
      secondary_schedule = pagerduty_schedule.schedules["team_b_secondary"].id
      manager_schedule = pagerduty_schedule.schedules["team_b_manager"].id
    }
    "team_c" = {
      name = "Team C (EP)"
      team = pagerduty_team.team_c.id
      primary_schedule = pagerduty_schedule.schedules["team_c_primary"].id
      secondary_schedule = pagerduty_schedule.schedules["team_c_secondary"].id
      manager_schedule = pagerduty_schedule.schedules["team_c_manager"].id
    }
  }
}

resource "pagerduty_escalation_policy" "escalation_policies" {
  for_each = local.escalation_policies
  name      = each.value.name
  teams     = [each.value.team]
  num_loops = 3
  rule {
    escalation_delay_in_minutes = 5
    target {
      type = "schedule_reference"
      id   = each.value.primary_schedule
    }
  }
  rule {
    escalation_delay_in_minutes = 15
    target {
      type = "schedule_reference"
      id   = each.value.secondary_schedule
    }
  }
  rule {
    escalation_delay_in_minutes = 25
    target {
      type = "schedule_reference"
      id   = each.value.manager_schedule
    }
  }
}