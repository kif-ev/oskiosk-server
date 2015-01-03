Feature: Self-service POS
  In order to let user self-service themselves
  As a conference organizer
  I want to allow a self-service POS

  Scenario: A user buys a product
    Given there are 10 items of a product "Turbriskafil" with the code "123"
    And there is a user "Howard" with the code "K00000007"
    When the POS is setup as anonymous
    And the code "123" is scanned
    And the code "K00000007" is scanned
    Then there should be only 9 "Turbriskafil" left
    And the price of 1 "Turbriskafil" should be debited from the account of "Howard"
