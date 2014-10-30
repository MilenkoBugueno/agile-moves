Feature: Registrating to a Certification
  In order to get a certification
  An user
  Should register to a certification

  Scenario: Registration button
    Given There is a certification available in the certificate view
    When I am not registered to it
    Then I see a register button

  Scenario: Registration
    Given There is a certification available in the certificate view
    And I am not registerd to it
    When I click on the register button
    And fill the registration with my review team
    Then I see the message Registration was successfully created