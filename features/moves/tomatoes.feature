  Feature: Tomatoes move
  In order to improve the time management skills
  A user
  Expect to create and manage tomato moves

  Scenario: create tomato move
    Given I am logged in
    When I create a 'Tomato' move
    Then I see the message Move was successfully created

  Scenario: delete tomato move
    Given I am logged in
    When I create a 'Tomato' move
    And I delete the 'Tomato' move in the move view
    Then I see the message Move was successfully deleted
