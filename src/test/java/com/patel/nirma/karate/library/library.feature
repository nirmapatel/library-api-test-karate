Feature: Library API

  Background:
    * url baseUrl
    * def isbnNo = 'asdfg'
    * def aisleNo = '11111'
    
#   This scenario verify below test cases
#   1. Add new book
#   2. Get book by author
#   3. Get book by id
#   4. Delete book
  Scenario: Verify book life cycle
    #   1. Add new book
    * path addBookPath
    * request { name: 'Learn API testing with karate', isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * method POST
    * print response
    * status 200
    * match response.ID == '#(isbnNo + aisleNo)'
    * match response.Msg == 'successfully added'
    * def bookId = response.ID
#   2. Get book by author
    * path getBookPath
    * param AuthorName = 'Nirma Patel'
    * method GET
    * print response
    * status 200
    * match response == [ { "isbn": '#(isbnNo)', "book_name": "Learn API testing with karate", "aisle": '#(aisleNo)' } ]
#   3. Get book by id
    * path getBookPath
    * param ID = bookId
    * method GET
    * print response
    * status 200
    * match response[0].isbn == '#(isbnNo)'
    * match response[0].book_name == 'Learn API testing with karate'
    * match response[0].aisle == '#(aisleNo)'
    * match response[0].author == 'Nirma Patel'
#   4. Delete book
    * path deleteBookPath
    * request { ID: '#(bookId)' }
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * method POST
    * print response
    * status 200
    * match response == { "msg": "book is successfully deleted" }