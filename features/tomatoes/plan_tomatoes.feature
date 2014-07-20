Feature: Plan tomatoes
  In order to improve the time management within the team
  a user
  creates and plans tomatoes

  Scenario: Create a new tomato
    Given I am in the plan view
    When I create 1 new tomatoes
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the activity inventory list


  Scenario: Create a tomato for today
    Given I am in the plan view
    When I create 1 new tomatoes for today
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the todo today list


  Scenario: Create a tomato for tomorrow
    Given I am in the plan view
    When I create 1 new tomatoes for tomorrow
    Then I see the message Tomato was successfully created
    And I see 1 tomatoes in the activity inventory list


  Scenario: Create several unplanned tomato
    Given I am in the plan view
    When I create 3 new tomatoes
    Then I see the message Tomato was successfully created
    And I see 3 tomatoes in the activity inventory list

  Scenario: Plan one tomato from any move
    Given I have 1 moves with tomatoes planned for today
    When I am in the plan view
    Then I see 1 tomatoes in the todo today list

  Scenario: Plan one tomato from any move
    Given I have 2 moves with tomatoes planned for today
    When I am in the plan view
    Then I see 2 tomatoes in the todo today list

  Scenario: Plan several tomatoes from several moves
    Given I have 7 moves with unplanned tomatoes
    When I am in the plan view
    Then I see 7 tomatoes in the activity inventory list

  Scenario: Done tomatoes are filtered out in the plan view
    Given I have 1 moves with tomatoes planned for yesterday
    When I am in the plan view
    Then I see 0 tomatoes in the todo today list
