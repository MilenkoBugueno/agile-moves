Feature: Certification List for Admins
  In order to administrate the certification process
  An admin
  Expect to create and manage certifications

  Scenario: Menu entry Certifications
    Given I am logged in as a admin
    When I click in the navigation bar on Administration
    Then I see the menu entry Certifications

  Scenario: Create a new Certification
    Given I am logged in as a admin
    And I am in the Certifications page
    When I create 1 new certifications
    Then I see the message Certification was successfully created

  Scenario: Set Certification Duration
    Given I am logged in as a admin
    And I am in the Certifications page
    When I'm creating a new Vision certification
    Then I can set the duration of the certification
