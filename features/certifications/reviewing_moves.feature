Feature: Reviewing Moves
  In order to review moves nominated to a certification
  An user
  Should see and review nominated moves

  Background:
    Given I am logged in


  Scenario: As Reviewer I can review 1 nominated Vision move
    Given mark nominates 1 Vision moves for VIS-03
    And I am reviewer for the certification
    When I go to my Work view
    Then I expect to see the nominated moves

  Scenario: I should not see nominated moves when I am not reviewer
    Given mark nominates 3 Vision moves for VIS-03
    And I am not reviewer for the certification
    When I go to my Work view
    Then I dont expect to see the nominated moves

  Scenario: As Reviewer I can review 3 nominated Vision moves
    Given mark nominates 3 Vision moves for VIS-03
    And I am reviewer for the certification
    When I go to my Work view
    Then I expect to see the nominated moves

  Scenario: As reviewer I can review 3 nominated Vision moves
    Given mark nominates 5 Tomato moves for TOM-01
    And I am reviewer for the certification
    When I go to my Work view
    Then I expect to see the nominated moves
