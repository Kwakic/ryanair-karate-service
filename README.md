# API REST TESTING RYANAIR

Application that tests Ryanair's Booking and Users API

## Getting Started/Install

This project is built over **Java** language, **Maven** build automation tool and **Karate** framework to perform testing tasks (version: 0.6.0.) <br /> 

### Run the tests
To launch application's tests, you must run the Maven command: **mvn clean test** under the root directory of the project:

```
C:\Users\mtp1946\Desktop\ryanair-karate-service-master>mvn clean test
[INFO] Scanning for projects...
[INFO]
[INFO] ---------------< es.martinsvach:ryanair-karate-service >----------------
[INFO] Building ryanair-karate-service 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ ryanair-karate-service ---
[INFO] Deleting C:\Users\mtp1946\Desktop\ryanair-karate-service-master\target
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ ryanair-karate-service ---
[WARNING] Using platform encoding (Cp1252 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory C:\Users\mtp1946\Desktop\ryanair-karate-service-master\src\main\resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ ryanair-karate-service ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ ryanair-karate-service ---
[WARNING] Using platform encoding (Cp1252 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 3 resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ ryanair-karate-service ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding Cp1252, i.e. build is platform dependent!
[INFO] Compiling 1 source file to C:\Users\mtp1946\Desktop\ryanair-karate-service-master\target\test-classes
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ ryanair-karate-service ---
[INFO] Surefire report directory: C:\Users\mtp1946\Desktop\ryanair-karate-service-master\target\surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running es.martinsvach.karate.TestRunner
22:07:03.296 [main] DEBUG com.intuit.karate.cucumber.CucumberRunner - init test class: class es.martinsvach.karate.TestRunner
```
## Complete Test Plan 

#### SWAGGER
Analyze the Swagger interface between booking-controller and user-controller and make sure that endpoints are correctly named, that resources and their types correctly reflect the object model, that there is no missing functionality or duplicate functionality, and that relationships between resources are reflected in the API correctly. <br /> 
```To do so, I applied mainly manual testing. ```

#### API TEST ACTIONS
* Verify correct HTTP status code. <br /> 
  *	For instance, I executed a POST request that creates a resource and returns an auto-generated identifier in its response. I then used this identifier to check if this resource is present in the list of elements received by a GET request.
* Verify response payload. <br /> 
  *	I checked if the JSON body is valid, if the fields are correctly named, and values are including error responses.
* Verify response headers.<br /> 
  * In our case is only **content-type": "application/json;charset=UTF-8** but I also checked in case there is one for security or login.
* Verify basic performance sanity. <br /> 
  * I only could check if operation was completed successfully, such as checking amount of time.

#### TEST SCENARIO CATEGORIES
My test cases fall into the following general test scenario groups:
*	Basic positive tests
*	Extended positive testing with optional parameters 
*	Negative testing with valid input
*	Negative testing with invalid input 
*	Security, authorization, and permission tests (Non Applicable in these test) 


## HTTP status codes 

* All requests should return HTTP status code.

* Returned status code that I was able to validate:
  * HTTP 200, HTTP 201, HTTP 400, HTTP 404, HTTP 409, HTTP 500. 
  * Non Applicable status codes HTTP 401 and 403 in these tests because authorization and permission scenarios are not present

## REST API - Test Action Description

Default Ryanair's database users haven't been used in my testing: ``` [
  {
    "email": "pepe@pepe.pe1",
    "name": "pepe",
    "id": "pepe@pepe.pe1-0.1",
    "bookings": []
  },
  {
    "email": "pepe@pepe.pe2",
    "name": "pepe",
    "id": "pepe@pepe.pe1-0.2",
    "bookings": []
  },
]```

**Instead I decided to create my own users by executing a previous Background step, therefore IDs will be different each time I run the test**


### Feature: Creating master user and make print for further use
>**Scenario:** Creating master user

#### Request URL

http://127.0.0.1:8900

#### Request 

POST /user

#### Success Response
201 <br />
Content-Type: application/json;charset=UTF-8 <br />
Date: Tue, 25 Feb 2020 19:12:40 GMT <br />
Transfer-Encoding: chunked <br />
{"email":"example@mixmail.com","name":"Chris Hope","id":"example@mixmail.com-0.728979976489025","bookings":[]} <br />


### Feature: Retrieve user <br />
> **Scenario:** Get a user by id

#### Request URL

http://127.0.0.1:8900

#### Request 

GET /user

#### Success Response


200
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 19:22:05 GMT<br />
Transfer-Encoding: chunked<br />
{"email":"example@mixmail.com","name":"Chris Hope","id":"example@mixmail.com-0.28277068320608967","bookings":[]}

### Feature: Retrieve user 

>**Scenario:** Get all users


#### Request URL

http://127.0.0.1:8900

#### Request

GET /user/all

#### Success Response

200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 19:50:18 GMT<br />
Transfer-Encoding: chunked<br />
[{"email":"pepe@pepe.pe1","name":"pepe","id":"pepe@pepe.pe1-0.1","bookings":[]},{"email":"pepe@pepe.pe2","name":"pepe","id":"pepe@pepe.pe1-0.2","bookings":[]},{"email":"example@mixmail.com","name":"Chris Hope","id":"example@mixmail.com-0.5880371756313284","bookings":[]},{"email":"example@mixmail.com","name":"Chris Hope","id":"example@mixmail.com-0.02145571254840939","bookings":[]}]

### Feature: Retrieve user 
> **Scenario:** Get a user with error and status 404

#### Request URL

http://127.0.0.1:8900

#### Request

GET /user

#### Error Response

404<br />
Content-Length: 14<br />
Content-Type: text/plain;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 20:00:36 GMT<br />
User not found<br />


### Feature: Retrieve user 
> **Scenario Outline:** Create a user with error
#### Request URL

http://127.0.0.1:8900

#### Request

GET /user

#### Error Response

201<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:24:13 GMT<br />
Transfer-Encoding: chunked<br />
{"email":"martin@mixmail.com","name":"Martin001","id":"martin@mixmail.com-0.08013469343403223","bookings":[]}<br /><br />


500<br />
Connection: close<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:24:13 GMT<br />
Transfer-Encoding: chunked<br />
{"timestamp":"2020-02-26T10:24:14.725+0000","status":500,"error":"Internal Server Error","message":"malformed email","path":"/user"}<br /><br />


409<br />
Content-Length: 12<br />
Content-Type: text/plain;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:24:13 GMT<br />
Check fields<br /><br />


409<br />
Content-Length: 12<br />
Content-Type: text/plain;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:24:14 GMT<br />
Check fields<br /><br />


409<br />
Content-Length: 12<br />
Content-Type: text/plain;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:24:14 GMT<br />
Check fields<br />



### Feature: Manage booking
> **Scenario Outline:** Create user's booking with success

#### Request URL

http://127.0.0.1:8900

#### Request

POST /booking

#### Success Response

201<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 20:38:51 GMT<br />
Transfer-Encoding: chunked<br />
{"idBooking":"PRG-MAD-0.802399791275208","idUser":"example@mixmail.com-0.8706070582301552","origin":"PRG","destination":"MAD","date":"2025-01-29"}


### Feature: Manage booking
> **Scenario Outline:** Create boooking user with Internal Server Error

#### Request URL

http://127.0.0.1:8900

#### Request

POST /booking

#### Error Response

500<br />
Connection: close<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 20:41:48 GMT<br />
Transfer-Encoding: chunked<br />
{"timestamp":"2020-02-25T20:41:48.620+0000","status":500,"error":"Internal Server Error","message":"could not execute statement; SQL [n/a]; constraint [\"FKTDE8EDPC976R2GJVN4RY5V9M7: PUBLIC.BOOKING FOREIGN KEY(ID_USER) REFERENCES PUBLIC.USER(ID) ('any')\"; SQL statement:\ninsert into booking (date, destination, id_user, origin, id_booking) values (?, ?, ?, ?, ?) [23506-196]]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement","path":"/booking"}



### Feature: Manage booking
> **Scenario Outline:** Get booking info by inserting valid ID leaving date empty

#### Request URL

http://127.0.0.1:8900

#### Request

GET /booking

#### Success Response

200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 21:11:46 GMT<br />
Transfer-Encoding: chunked<br />
[{"idBooking":"PRG-MAD-0.7691706964168324","idUser":"example@mixmail.com-0.5451029768190258","origin":"PRG","destination":"MAD","date":"2025-01-29"}]


### Feature: Manage booking
> **Scenario Outline:** Get booking info by inserting valid ID without date 

#### Request URL

http://127.0.0.1:8900

#### Request

GET /booking

#### Success Response
200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 21:14:36 GMT<br />
Transfer-Encoding: chunked<br />
[{"idBooking":"PRG-MAD-0.5550643715440788","idUser":"example@mixmail.com-0.8064063999369496","origin":"PRG","destination":"MAD","date":"2025-01-29"}]


### Feature: Manage booking
> **Scenario Outline:** Get booking info by inserting valid date leaving ID empty
#### Request URL

http://127.0.0.1:8900

#### Request

GET /booking

#### Success Response
200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 21:20:34 GMT<br />
Transfer-Encoding: chunked<br />
[{"idBooking":"PRG-MAD-0.4463368407864515","idUser":"example@mixmail.com-0.710428531570816","origin":"PRG","destination":"MAD","date":"2025-01-29"}]


### Feature: Manage booking
> **Scenario Outline:** Get booking info by insterting valid date without ID
#### Request URL

http://127.0.0.1:8900

#### Request

GET /booking

#### Success Response
200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 21:23:38 GMT<br />
Transfer-Encoding: chunked<br />
[{"idBooking":"PRG-MAD-0.01566791471779827","idUser":"example@mixmail.com-0.9520295290286177","origin":"PRG","destination":"MAD","date":"2025-01-29"}]




### Feature: Manage booking
> **Scenario Outline:** Get booking info by inserting valid date and ID, and match response body
#### Request URL

http://127.0.0.1:8900

#### Request

GET /booking

#### Success Response
200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Tue, 25 Feb 2020 21:28:57 GMT<br />
Transfer-Encoding: chunked<br />
[{"idBooking":"PRG-MAD-0.22256632795012665","idUser":"example@mixmail.com-0.31897199215460625","origin":"PRG","destination":"MAD","date":"2025-01-29"}]


### Feature: Manage booking
> **Scenario Outline:** Get empty response inserting invalid inputs
#### Request URL

http://127.0.0.1:8900

#### Request

GET /booking

#### Success/Error Response

200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:38:10 GMT<br />
Transfer-Encoding: chunked<br />
[]<br /><br />

200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:38:11 GMT<br />
Transfer-Encoding: chunked<br />
[]<br /><br />

200<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:38:11 GMT<br />
Transfer-Encoding: chunked<br />
[]<br /><br />

400
Connection: close<br />
Content-Length: 30<br />
Content-Type: text/plain;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:38:11 GMT<br />
Bad request: date and id empty<br /><br />

500<br />
Connection: close<br />
Content-Type: application/json;charset=UTF-8<br />
Date: Wed, 26 Feb 2020 10:38:12 GMT<br />
Transfer-Encoding: chunked<br />
{"timestamp":"2020-02-26T10:38:12.708+0000","status":500,"error":"Internal Server Error","message":"Format date not valid","path":"/booking"}









