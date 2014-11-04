Feature: Nominating Moves
  In order to get a certification
  An user
  Should nominate moves to a certification

  Scenario: I can nominate vision moves to the certification VIS-03
    Given I am registered to VIS-03
    When I'm creating a 'vision' move
    Then I see the button Nominate

    



