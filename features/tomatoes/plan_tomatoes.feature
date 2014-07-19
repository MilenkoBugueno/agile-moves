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

  Scenario: Plan one tomato from any move
    Given I am logged in
    And I have a move with 1 tomato planned for today
    When I am in the plan view
    Then I see 1 tomatoes in the todo today list

  Scenario: Plan one tomato from any move
    Given I am logged in
    And I have a move with 2 tomato planned for today
    When I am in the plan view
    Then I see 2 tomatoes in the todo today list

  Scenario: Plan several tomatoes from several moves
    Given I am logged in
    And I have several moves with 7 unplanned tomatoes
    When I am in the plan view
    Then I see 7 tomatoes in the activity inventory list
