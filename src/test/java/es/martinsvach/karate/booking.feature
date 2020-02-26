Feature: Manage booking

  Background:
    * def baseUrl = 'http://127.0.0.1:8900'
    * def user = callonce read('create_user.feature')
  	* def userid = user.response.id
    * def testdate = "2025-01-29"
    * def Desfrom = "PRG"
  	* def Desto = "MAD"

  Scenario: Create user's booking with success
  * def booking =   
"""
    {
  "date": "#(testdate)",
  "destination": "#(Desto)",
  "id": "#(userid)",
  "origin": "#(Desfrom)"
}
"""
    Given url baseUrl
    And path 'booking'
    And header Content-Type = 'application/json'
    And request booking
    When method post
    Then status 201
    And match response.date == testdate 
    And match response.idUser == userid
    And match response.origin == Desfrom 
    And match response.destination == Desto


 Scenario: Create user's booking with Internal Server Error
  * def booking =   
"""
    {
  "date": "#(testdate)",
  "destination": "#(Desto)",
  "id": "any",
  "origin": "#(Desfrom)"
}
"""
    Given url baseUrl
    And path 'booking'
    And header Content-Type = 'application/json'
    And request booking
    When method post
    Then status 500
    And match $ == 
   """
     {
  "timestamp": "#notnull",
  "status": 500,
  "error": "Internal Server Error",
  "message": "#notnull",
  "path": "/booking"
     }  
    """

  Scenario: Get booking info by inserting valid ID leaving date empty
    Given url baseUrl
    And path 'booking'
    And params { "id": "#(userid)", "date": "" }
    When method get
    Then status 200
    And print userid
    And print response
    And match response[*].idUser contains userid 
 
   
  Scenario: Get booking info by inserting valid ID without date 
    Given url baseUrl
    And path 'booking'
    And param id = userid
    When method get
    Then status 200
    And match response[*].idUser contains userid 

  Scenario: Get booking info by inserting valid date leaving ID empty
    Given url baseUrl
    And path 'booking'
    And params { "id": "", "date": "2025-01-29" }
    When method get
    Then status 200
    And match response[*].date contains testdate 

  Scenario: Get booking info by insterting valid date without ID
    Given url baseUrl
    And path 'booking'
    And param date = '2025-01-29'
    When method get
    Then status 200
    And match response[*].date contains testdate
   
  Scenario: Get booking info by inserting valid date and ID, and match response body
    Given url baseUrl
    And path 'booking'
    And params { "id": "#(userid)", "date": "2025-01-29" }
    When method get
    Then status 200
    And match response[*].date contains testdate 
    And match response[*].idUser contains userid 


Scenario Outline: Get empty response inserting invalid inputs
    Given url baseUrl
    And path 'booking'
    And params { id: '<id>', date: '<date>' }
    When method get
    Then status <status>
    And match $ == <response>

Examples:
	| id       | date      | status	|response																																																																	|
  | see      |           |  200		|[]    	 																																																																	| 
  | anything |2010-02-09 |  200		|[]    	 																																																																	|  
  |          |2010-02-18 |  200		|[]    	 																																																																	| 
  |          |					 |  400		|'Bad request: date and id empty'    																																																			| 
  | #(userid)|2020-13-01 |  500		|{"timestamp": "#notnull", "status": 500,  "error": "Internal Server Error", "message": "Format date not valid", "path": "/booking" }    	| 
