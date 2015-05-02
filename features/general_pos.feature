Feature: General POS

  Scenario: Conflict in requested products
    Given there is a POS
    And there are 2 items of a product "Perriair" with the code "123"
    When the code "123" is scanned
    And the code "123" is scanned
    And the code "123" is scanned
    Then there should be an error

  Scenario: Deposit money to a user's account
    Given there is a POS
    And there is a user "Howard" with the code "007"
    When the user "Howard" makes a "10,00"€ deposit
    Then the account of user "Howard" should be credited with "10,00"€
