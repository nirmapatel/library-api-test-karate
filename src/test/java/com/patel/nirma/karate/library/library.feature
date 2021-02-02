Feature: Library API

  Background:
    * url baseUrl
    * def isbnNo = 'asdfg'
    * def aisleNo = '11111'

  Scenario: Add new book
    * path addBookPath
    * request { name: 'Learn API testing with karate', isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * header Accept = 'application/json'
    * method POST
    * print response
    * status 200
    * match response == {ID: '#(isbnNo + aisleNo)', Msg: 'successfully added' }


  Scenario: Get book by author
    * path getBookPath
    * param AuthorName = 'Nirma Patel'
    * method GET
    * print response
    * status 200
    * match response == [ { "isbn": '#(isbnNo)', "book_name": "Learn API testing with karate", "aisle": '#(aisleNo)' } ]


  Scenario: Get book by id
    * path getBookPath
    * param ID = isbnNo + aisleNo
    * method GET
    * print response
    * status 200
    * match response == [ { "isbn": '#(isbnNo)', "book_name": "Learn API testing with karate", "aisle": '#(aisleNo)', "author": "Nirma Patel" } ]


  Scenario: Delete book
    * path deleteBookPath
    * request { ID: '#(isbnNo + aisleNo)' }
    * header Accept = 'application/json'
    * method POST
    * print response
    * status 200
    * match response == { "msg": "book is successfully deleted" }