Feature: Complete Sprint
  In order to improve the time management within the team
  a user
  creates an sprint and plan tomatoes

  Background:
    Given I am logged in

  Scenario: Complete actual sprint
    Given I have a active sprint with 3 done and 3 not done tomatoes
    When I go to my Plan view
    And I press the button Complete Sprint
    And I go to my Plan view
    Then I see the message NO CURRENT SPRINT

  Scenario: Copy not done tomatoes to the activity inventory
    Given I have a active sprint with 3 done and 3 not done tomatoes
    When I go to my Plan view
    And I press the button Complete Sprint
    And I go to my Plan view
    Then I see 3 not done tomatoes
