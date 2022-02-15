resource "pagerduty_response_play" "major_incident_response_play" {

  # Summary
  name        = "Major Incident Response"
  from        = local.users["user_a3"].email
  description = "Response play for Major Incident (P1/P2)"

  # What should happen when this play runs?
  conference_number = "+1-555-555-5555,,1234#"
  conference_url = "https://myconference.bridge.com/123-456-678"

  # Mobilise all teams
  responder {
    type = "escalation_policy_reference"
    id   = pagerduty_escalation_policy.escalation_policies["team_a"].id
  }

  responder {
    type = "escalation_policy_reference"
    id   = pagerduty_escalation_policy.escalation_policies["team_b"].id
  }
  
  responder {
    type = "escalation_policy_reference"
    id   = pagerduty_escalation_policy.escalation_policies["team_c"].id
  }

  responders_message = "Requesting assistance with major incident"

  # Add business subscribers (Team D)
  subscriber {
    type = "team_reference"
    id   = pagerduty_team.team_d.id
  }

  subscribers_message = "Major incident identified - teams have been mobilised"

  # Who can run this play on demand?
  runnability = "responders"
}