Feature: Plan tomatoes
  In order to improve the time management within the team
  a user
  creates and plans tomatoes

  Scenario: Create a new tomato
    Given I am logged in
    And I am in the plan view
    When I create a new tomato
    Then I see the message Tomato was successfully created


  Scenario: Create a tomato for today
    Given I am logged in
    And I am in the plan view
    When I create a new tomato for today
    Then I see the message Tomato was successfully created
    And I see the tomato in the todo today list


  Scenario: Create a tomato for tomorrow
    Given I am logged in
    And I am in the plan view
    When I create a new tomato for tomorrow
    Then I see the message Tomato was successfully created
    And I see the tomato in the activity inventory list


  Scenario: Create an unplanned tomato
    Given I am logged in
    And I am in the plan view
    When I create a new tomato for tomorrow
    Then I see the message Tomato was successfully created
    And I see the tomato in the activity inventory list
