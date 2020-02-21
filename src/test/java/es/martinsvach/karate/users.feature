Feature: Test Ryanair Users API
  Background:
  	  * def baseUrl = 'http://127.0.0.1:8900'

  Scenario: Create a user with success
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: 'Ricardo Molina', email: 'toorop@mixmail.com' }
    When method post
    Then status 201
	  
	  Scenario Outline: Create a user with error
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: <name>, email: <email> }
    When method post
    Then status 500
	  And match response == {"timestamp": "#notnull", "status": 500,"error": "Internal Server Error","message": "malformed email","path": "/user"	}
	  
	  Examples:
	  | name          | email 								|
    | 'Ricardo001'  | 'mixmail.com'   			|
    | 'Ricardo002'  | 'tooropmixmail.com'   |