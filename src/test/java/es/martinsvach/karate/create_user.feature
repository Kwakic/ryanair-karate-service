Feature: Creating master user for tests

  Background:
  	  * def baseUrl = 'http://127.0.0.1:8900'
  	  
  Scenario: Create a user with success
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: 'Chris Hope', email: 'example@mixmail.com' }
    When method post
    Then status 201
    And print response

