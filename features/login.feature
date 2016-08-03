Feature: Log in
  In order to use the system
  As a user
  I have to login first

  Background:
    Given the system has these users:
    | email           | password |
    | bruno@gmail.com | 12345678 |

  Scenario: Registered user tries to login
    Given I'm a registered user
    And I send my credentials to login path
    Then I should receive a session token

  Scenario: User enters wrong credentials
    Given I'm a registered user
    But I send my credentials wrong to login path
    Then I should receive a response with status 401

  Scenario: Unregistered user tries to login
    Given I'm not a registered user
    And I send my credentials to login path
    Then I should receive a response with status 401
