Feature: Todo today
  In order to improve the team skills
  A user
  Expect to create and manage todo today moves

  Scenario: No tomatoes are planned in todo today
    Given I am logged in
    And '0' tomatoes of me are planned for today
    When I create a 'Todo Today' move
    Then I see a move created message
    And I see '0' tomatoes in the tomatoes list widget

  Scenario: 2 tomatoes are planned in todo today
    Given I am logged in
    And '2' tomatoes of me are planned for today
    When I create a 'Todo Today' move
    Then I see a move created message
    And I see '2' tomatoes in the tomatoes list widget
