Feature: User management
  In order to control user accounts
  As an administrator
  I want to manage user accounts in the system
  @javascript
  Scenario Outline: Authorization for user
    Given I log in as <role>
    And another user named Al Smith exists
    Then I <create> create users
    And I <authorize> authorize users
    And I <update> update users
    And I <destroy> destroy users
    Examples:
      | role  | create | authorize | update  | destroy |
      | admin | may    | may       | may     | may     |
      | staff | may    | may not   | may     | may not |
  @javascript
  Scenario: List users
    Given I log in as admin
    When I go to the users listing
    Then I should see myself in the users listing
  @javascript
  Scenario Outline: Search for users
    Given I log in as admin
    And another user named Al Smith exists
    And another user named Fiorello Laguardia exists
    And another user named John Smith exists
    When I go to the users listing
    And I search for "<search>"
    Then I should <al> Al Smith in the users listing
    And I should <fio> Fiorello Laguardia in the users listing
    And I should <john> John Smith in the users listing
    Examples:
      | search | al      | fio     | john    |
      | smith  | see     | not see | see     |
      | fior   | not see | see     | not see |
  @javascript
  Scenario: Create user
    Given I log in as admin
    When I go to the users listing
    And I create another user named Al Smith
    Then I should see the user was created
    And I should see Al Smith in the users listing
  @javascript
  Scenario: Edit user
    Given I log in as admin
    And another user named Al Smythe exists
    When I go to the users listing
    And I edit Al Smythe in the users listing
    Then I should see the user was updated
    And the user should be updated
    And I should not see Al Smythe in the users listing
    And I should see Alfred Smith in the users listing
  @javascript
  Scenario: Authorize user for jurisdiction
    Given I log in as admin
    And another user named Al Smith exists
    And a jurisdiction "Binghamton" exists
    When I add a membership for Al Smith to propose for "Binghamton"
    Then Al Smith may propose for "Binghamton"
  @javascript
  Scenario: Unauthorize user for jurisdiction
    Given I log in as admin
    And another user named Al Smith exists
    And a jurisdiction "Binghamton" exists
    When I add a membership for Al Smith to adopt for "Binghamton"
    Then Al Smith may adopt for "Binghamton"
    When I remove the membership for Al Smith for "Binghamton"
    Then Al Smith may not adopt for "Binghamton"
  @javascript
  Scenario: Remove user
    Given I log in as admin
    And another user named Al Smith exists
    And I go to the users listing
    When I remove Al Smith from the users listing
    Then I should not see Al Smith in the users listing
