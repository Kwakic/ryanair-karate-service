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

	  Scenario Outline: Create a user with error
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: '<name>', email: '<email>' }
    When method post
    Then status <status>
	  And match response == <response>
	  
	  Examples:
	  | name       | email 							|status |response																																																												|
    | Martin001  | martin@mixmail.com |201		|	{"email": "martin@mixmail.com", "name": "Martin001","id": "#notnull","bookings": []	}        																	|
    | Martin002  | hellopmixmail.com  |500    | {"timestamp": "#notnull", "status": 500,"error": "Internal Server Error","message": "malformed email","path": "/user"	}       |
		|   				 | hellopmixmail.com  |409    | "Check fields"        																																																				|
		| Martin002  | 								    |409    | "Check fields"        																																																				|
		|  					 | 								    |409    | "Check fields"        																																																				|


    