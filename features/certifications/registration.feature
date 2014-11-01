Feature: Registration to a Certification
  In order to get a certification
  An user
  Should register to a certification

  Scenario: Registration button
    Given I am logged in
    When I am in the certificate view
    And A new certification is available
    Then I see the button register

  Scenario: Registration
    Given I am logged in
    And I am in the certificate view
    And A new certification is available
    When I click on the button register
    And fill the registration with my review team
    Then I see the message Registration was successfully created

