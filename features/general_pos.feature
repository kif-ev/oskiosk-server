Feature: General POS

  Scenario: Conflict in requested products
    Given there is a POS
    And there are 2 items of a product "Perriair" with the code "123"
    When the code "123" is scanned
    And the code "123" is scanned
    And the code "123" is scanned
    Then there should be an error
