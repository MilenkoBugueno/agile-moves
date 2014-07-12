Feature: Plan tomatoes
  In order to improve the time management within the team
  a user
  creates and plans tomatoes

  Scenario: Create a new tomato
    Given I am logged in
    And I am in the plan view
    When I create a new tomato
    Then I see a Tomato was successfully created message
