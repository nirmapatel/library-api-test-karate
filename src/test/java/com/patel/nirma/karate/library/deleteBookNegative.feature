Feature: Library -> add new book API -ve tests

  Background:
    * url baseUrl

  Scenario: Delete book with empty request
    * path deleteBookPath
    * request {  }
    * header Accept = 'application/json'
    * method POST
    * print response
    * status 200
#    Here, we haven't received response json with 'book is successfully deleted' message. Ideally endpoint should return unsuccessful status code.
    * match response == ''