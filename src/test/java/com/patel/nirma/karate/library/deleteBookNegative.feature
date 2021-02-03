Feature: Library -> delete book API -ve tests

  Background:
    * url baseUrl

  Scenario: Delete book with empty request
    * path deleteBookPath
    * header Accept = 'application/json'
    * request {  }
    * method POST
    * print response
    * status 200
#    Here, we haven't received response json with 'book is successfully deleted' message. Ideally endpoint should return unsuccessful status code.
    * match response == ''

  Scenario: Delete book with wrong id
    * path deleteBookPath
    * header Accept = 'application/json'
#    Hopefully book with this id doesn't exists
    * request { ID: '1q2w3e4r5t6y' }
    * method POST
    * print response
    * status 404