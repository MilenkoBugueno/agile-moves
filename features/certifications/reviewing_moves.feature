Feature: Reviewing Moves
  In order to review moves nominated to a certification
  An user
  Should see and review nominated moves


  Scenario: As Reviewer I can review nominated moves
    Given user1 nominates a move for a certification
    And I am reviewer for his certification
    When I go to my work view
    Then I expect to see the nominated move
