Feature: Plan tomatoes
  In order to improve the time management within the team
  a user
  creates and plans tomatoes

  Scenario: Create a new tomato
    Given I am logged in
    And I am in the plan view
    When I create 1 new tomatoes
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the activity inventory list


  Scenario: Create a tomato for today
    Given I am logged in
    And I am in the plan view
    When I create 1 new tomatoes for today
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the todo today list


  Scenario: Create a tomato for tomorrow
    Given I am logged in
    And I am in the plan view
    When I create 1 new tomatoes for tomorrow
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the activity inventory list


  Scenario: Create several unplanned tomato
    Given I am logged in
    And I am in the plan view
    When I create 3 new tomatoes
    Then I see the message Tomato was successfully created
    And I see 3 tomatoes in the activity inventory list
