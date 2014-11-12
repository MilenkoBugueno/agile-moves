Feature: Progress of my Certification
  In order to track the Certification
  An user
  Should see the progress of the Certification

  Background:
    Given I am logged in


  Scenario: No nominated moves
    Given I am registered to VIS-03
    And my certification has 0 nominated Vision moves
    When I go to my Certificate view
    Then I see in the progress bar '0/10'

  Scenario: 2 nominated but not reviewed moves
    Given I am registered to VIS-03
    And my certification has 2 nominated Vision moves
    When I go to my Certificate view
    Then I see in the progress bar '0/10'

  Scenario: 2 approved moves
    Given I am registered to VIS-03
    And my certification has 2 approved Vision moves
    When I go to my Certificate view
    Then I see in the progress bar '2/10'

  Scenario: 2 approved moves and 3 nominated moves
    Given I am registered to VIS-03
    And my certification has 1 nominated Vision moves
    And my certification has 3 approved Vision moves
    When I go to my Certificate view
    Then I see in the progress bar '3/10'

  Scenario: 2 approved moves and 3 nominated moves
    Given I am registered to VIS-03
    And my certification has 1 nominated Vision moves
    And my certification has 3 approved Vision moves
    When I go to my Certificate view
    Then I see in the progress bar '3/10'

  Scenario: certification completed
    Given I am registered to VIS-03
    And my certification has 10 approved Vision moves
    When I go to my Certificate view
    Then I see in the progress bar '10/10'
