Feature: Reviewing Moves
  In order to review moves nominated to a certification
  An user
  Should see and review nominated moves


  Scenario: As Reviewer I can review nominated moves
    Given mark nominates a Vision move for VIS-03
    And I am reviewer for the certification
    When I go to my work view
    Then I expect to see the nominated move

  Scenario: I should not see nominated moves when I am not reviewer
    Given mark nominates a Vision move for VIS-03
    And I am not reviewer for the certification
    When I go to my work view
    Then I dont expect to see the nominated move
