Feature: Move Approval
  In order to see whether a move is approved or not
  An user
  Should see the approval state

  Background:
    Given I am logged in


  Scenario: 1 approval
    Given I am registered to VIS-03
    And my nominated 'vision' move has been 1 times approved
    Then I see 1 approval in the inscription page
    #Then I see 1 approval in the approval widget

