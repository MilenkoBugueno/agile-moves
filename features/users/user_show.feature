Feature: Show Users
  As a admin
  I want to see registered users listed on the homepage
  so I can know if the site has users

    Scenario: Viewing users
      Given I exist as a admin
      And I am logged in as a admin
      When I look at the list of users
      Then I should see my name
