locals {
  users = {
    "user_a1" = {
      "name"      = "User A1"
      "email"     = "user_a1@example.com"
      "base_role" = "observer"
      "team_role" = "responder"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_a.id
    }
    "user_a2" = {
      "name"      = "User A2"
      "email"     = "user_a2@example.com"
      "base_role" = "observer"
      "team_role" = "responder"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_a.id
    }
    "user_a3" = {
      "name"      = "User A3"
      "email"     = "user_a3@example.com"
      "base_role" = "user"
      "team_role" = "manager"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_a.id
    }
    "user_b1" = {
      "name"      = "User B1"
      "email"     = "user_b1@example.com"
      "base_role" = "observer"
      "team_role" = "responder"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_b.id
    }
    "user_b2" = {
      "name"      = "User B2"
      "email"     = "user_b2@example.com"
      "base_role" = "observer"
      "team_role" = "responder"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_b.id
    }
    "user_b3" = {
      "name"      = "User B3"
      "email"     = "user_b3@example.com"
      "base_role" = "user"
      "team_role" = "manager"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_b.id
    }
    "user_c1" = {
      "name"      = "User C1"
      "email"     = "user_c1@example.com"
      "base_role" = "observer"
      "team_role" = "responder"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_c.id
    }
    "user_c2" = {
      "name"      = "User C2"
      "email"     = "user_c2@example.com"
      "base_role" = "observer"
      "team_role" = "responder"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_c.id
    }
    "user_c3" = {
      "name"      = "User C3"
      "email"     = "user_c3@example.com"
      "base_role" = "user"
      "team_role" = "manager"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_c.id
    }
    "user_d1" = {
      "name"      = "User D1"
      "email"     = "user_d1@example.com"
      "base_role" = "read_only_user"
      "team_role" = "observer"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_d.id
    }
    "user_d2" = {
      "name"      = "User D2"
      "email"     = "user_d2@example.com"
      "base_role" = "read_only_user"
      "team_role" = "observer"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_d.id
    }
    "user_d3" = {
      "name"      = "User D3"
      "email"     = "user_d3@example.com"
      "base_role" = "read_only_user"
      "team_role" = "observer"
      "time_zone" = "Europe/London"
      "team"      = pagerduty_team.team_d.id
    }
  }
}

resource "pagerduty_user" "users" {
  for_each = local.users
  name     = each.value.name
  email    = each.value.email
  role     = each.value.base_role
}

resource "pagerduty_team_membership" "team_memberships" {
  for_each = local.users
  user_id  = pagerduty_user.users[each.key].id
  team_id  = local.users[each.key].team
  role     = local.users[each.key].team_role
}