  Feature: Inscription to a Certification
  In order to get a certification
  An user
  Should register to a certification

  Scenario: Registration button for TOM-01
    Given I am logged in
    And I am not registered to any certification
    When I am in the Certificate view
    Then I see the entry TOM-01
    And I see the button register

  Scenario: Registration for TOM-01
    Given I am logged in
    And I am not registered to any certification
    When I am in the Certificate view
    And I click for TOM-01 on the button register
    And fill the registration with my review team
    Then I land in the Certificate view
    And I see the message Registration was successfully created

    Scenario: Duration for TOM-01
      Given I am logged in
      And I am not registered to any certification
      When I am in the Certificate view
      And I click on the button register
      And fill the registration with the start date '2014-11-11'
      Then I see the message Registration was successfully created
      And I see for TOM-01 the duration '11 Nov - 11 Dec'

