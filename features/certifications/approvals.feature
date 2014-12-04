Feature: Move Approval
  In order to see whether a move is approved or not
  An user
  Should see the approval state

  Background:
    Given I am logged in


  Scenario: No approvals
    Given I am registered to VIS-03
    And my nominated 'vision' move has been 0 times approved
    When I go to my Certificate view
    And I click on the button Warum aufstehen?
    Then I see 0 approvals

  Scenario: 1 approval
    Given I am registered to VIS-03
    And my nominated 'vision' move has been 1 times approved
    When I go to my Certificate view
    And I click on the button Warum aufstehen?
    Then I see 1 approvals

  Scenario: 2 approvals
    Given I am registered to VIS-03
    And my nominated 'vision' move has been 2 times approved
    When I go to my Certificate view
    And I click on the button Warum aufstehen?
    Then I see 2 approvals

  Scenario: 3 approvals
    Given I am registered to VIS-03
    And my nominated 'vision' move has been 3 times approved
    When I go to my Certificate view
    And I click on the button Warum aufstehen?
    Then I see 3 approvals
