Feature: Nominating Moves
  In order to get a certification
  An user
  Should nominate moves to a certification
  where the certification should be reviewed by the peer reviewers

  Scenario: As Reviewer I can review nominated moves
    Given user1 nominates a move for a certification
    And I am reviewer for his certification
    When I go to my work view
    Then I expect to see the nominated move



