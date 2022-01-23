resource "pagerduty_team" "team_a" {
  name        = "Team A"
  description = "Team A"
}

resource "pagerduty_team" "team_b" {
  name        = "Team B"
  description = "Team B"
}

resource "pagerduty_team" "team_c" {
  name        = "Team C"
  description = "Team C"
}

resource "pagerduty_team" "team_d" {
  name        = "Team D"
  description = "Team D (Stakeholders)"
}