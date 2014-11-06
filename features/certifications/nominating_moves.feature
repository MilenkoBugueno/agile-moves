Feature: Nominating Moves
  In order to get a certification
  An user
  Should nominate moves to a certification

  Scenario: I can nominate a move in the new form
    Given I am logged in
    And I am registered to VIS-03
    When I'm creating a 'vision' move
    Then I see the button Nominate

  Scenario: I can nominate a vision move to VIS-03
    Given I am logged in
    And I am registered to VIS-03
    When I'm creating a 'vision' move
    And I click on the button Nominate
    Then I see the entry VIS-03 (Apprentice)

  Scenario: I nominate a vision move to VIS-03
    Given I am logged in
    And I am registered to VIS-03
    When I nominate a 'vision' move to VIS-03
    Then I see the message Move was successfully created and nominated to the certification VIS-03

