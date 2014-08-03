Feature: Plan tomatoes
  In order to improve the time management within the team
  a user
  creates an sprint and plan tomatoes

  Scenario: Create a new sprint
    Given I am in the sprint plan view
    And no sprint is planned
    When I create a new sprint
    Then I see the message Move was successfully created
    And I see the sprint in the plan view
    And I don't see a "Create New Sprint" button

  Scenario: Create a tomato for today
    Given I am in the sprint plan view
    When I create 1 new tomatoes for today
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the todo today list

  Scenario: Create a tomato for tomorrow
    Given I am in the sprint plan view
    When I create 1 new tomatoes for tomorrow
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the activity inventory list


