# API REST TESTING RYANAIR

Booking Controller and User Controller

## Getting Started/Install

This project is built over **Java** language, **Maven** build automation tool and **Karate** framework to perform testing tasks.<br /> 

### Run the tests
To launch application's tests developed under Karate framework, you must run the command: **mvn clean test** , under the root directory of the project:

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
  * Non Applicable status codes HTTP 401 and 403 in these tests.

## REST API - Test Action Description

Users already created from your database haven't been used in my testing: ``` [
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

**I decided to create my own users by making a print, therefore IDs will be different each time I run the test**

### Feature: Creating master user and make print for further use
>**Scenario:** Create a user with success

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

- Status 200<br />
- Match Response Body with all users created<br />
