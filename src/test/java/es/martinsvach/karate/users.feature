Feature: Retrieve user/s

  Background:
  	  * def baseUrl = 'http://127.0.0.1:8900'
  	  * def user = callonce read('create_user.feature')
  	  * def userid = user.response.id
  	 

 Scenario: Get a user by id
    Given url baseUrl
    And path 'user'
    And param id = userid
    When method get
    Then status 200
    And match $ == {"email": "example@mixmail.com","name": "Chris Hope","id": "#notnull","bookings": [] } 
    
  Scenario: Get all users
    Given url baseUrl
    And path 'user/all'
    When method get
    Then status 200
    And match response[*].id contains userid

  Scenario: Get a user with error and status 404
    Given url baseUrl
    And path 'user'
    And param id = 'nonexisting.dd'
    When method get
    Then status 404
    And match response == "User not found"


	  Scenario Outline: Create a user with error and status 500
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: '<name>', email: '<email>' }
    When method post
    Then status 500
	  And match response == <response>
	  
	  Examples:
	  | name       | email 							|response|
    | Martin001  | mixmail.com   			|{"timestamp": "#notnull", "status": 500,"error": "Internal Server Error","message": "malformed email","path": "/user"	}        |
    | Martin002  | hellopmixmail.com  |{"timestamp": "#notnull", "status": 500,"error": "Internal Server Error","message": "malformed email","path": "/user"	}        |


    Scenario Outline: Create a user with error and status 400
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { email: 'ecfff@kdkd.com'}
    When method post
    Then status 400
	  And match response == 
    """
  {
  "timestamp": "#notnull",
  "status": 400,
  "error": "Bad Request",
  "message": "#notnull",
  "path": "/user"
   }

   """

	  Scenario Outline: Create a user with error and status 409
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: '<name>', email: '<email>' }
    When method post
    Then status <status>
	  
	  Examples:
	  | name        | email 							|status|
    |             | anything@yahoo.com  |409   |
    