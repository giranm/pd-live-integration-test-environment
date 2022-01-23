locals {
  schedules = {
    "team_a_primary" = {
      name = "Team A (Primary)"
      users = [
        pagerduty_user.users["user_a1"].id,
        pagerduty_user.users["user_a2"].id,
      ]
    }
    "team_a_secondary" = {
      name = "Team A (Secondary)"
      users = [
        pagerduty_user.users["user_a2"].id,
        pagerduty_user.users["user_a1"].id,
      ]
    }
    "team_a_manager" = {
      name = "Team A (Manager)"
      users = [
        pagerduty_user.users["user_a3"].id
      ]
    }
    "team_b_primary" = {
      name = "Team B (Primary)"
      users = [
        pagerduty_user.users["user_b1"].id,
        pagerduty_user.users["user_b2"].id,
      ]
    }
    "team_b_secondary" = {
      name = "Team B (Secondary)"
      users = [
        pagerduty_user.users["user_b2"].id,
        pagerduty_user.users["user_b1"].id,
      ]
    }
    "team_b_manager" = {
      name = "Team B (Manager)"
      users = [
        pagerduty_user.users["user_b3"].id
      ]
    }
    "team_c_primary" = {
      name = "Team C (Primary)"
      users = [
        pagerduty_user.users["user_c1"].id,
        pagerduty_user.users["user_c2"].id,
      ]
    }
    "team_c_secondary" = {
      name = "Team C (Secondary)"
      users = [
        pagerduty_user.users["user_c2"].id,
        pagerduty_user.users["user_c1"].id,
      ]
    }
    "team_c_manager" = {
      name = "Team C (Manager)"
      users = [
        pagerduty_user.users["user_c3"].id
      ]
    }
  }
}

resource "pagerduty_schedule" "schedules" {
  for_each = local.schedules
  name      = each.value.name
  time_zone = "Europe/London"
  layer {
    name                         = "Weekly Rotation"
    start                        = "2022-01-03T00:00:00+00:00"
    rotation_virtual_start       = "2022-01-03T08:00:00+00:00"
    rotation_turn_length_seconds = 604800
    users                        = each.value.users
  }
}