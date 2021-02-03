Feature: Library -> add new book API -ve tests

  Background:
    * url baseUrl
    * def isbnNo = 'qwert'
    * def aisleNo = '99999'

  Scenario: Add new book without name
    * path addBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * method POST
    * print response
    * status 200
#    Here, we haven't received response json with 'successfully added' message. Ideally endpoint should return unsuccessful status code.
    * match response == ''
#    For double verification, try to get the book by ID. Should receive failure status code.
    * path getBookPath
    * param ID = isbnNo + aisleNo
    * method GET
    * print response
    * status 404
    * match response == { "msg": "The book by requested bookid / author name does not exists!"}

  Scenario: Add new book without author
    * path addBookPath
    * header Accept = 'application/json'
    * request { name: 'Learn API testing with karate - Part 2', isbn: '#(isbnNo)', aisle: '#(aisleNo)'}
    * method POST
    * print response
    * status 200
#    Here, we haven't received response json with 'successfully added' message. Ideally endpoint should return unsuccessful status code.
    * match response == ''
#    For double verification, try to get the book by ID. Should receive failure status code
    * path getBookPath
    * param ID = isbnNo + aisleNo
    * method GET
    * print response
    * status 404
    * match response == { "msg": "The book by requested bookid / author name does not exists!"}

  Scenario: Add new book without isbn
    * path addBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { name: 'Learn API testing with karate - Part 2', aisle: '#(aisleNo)', author: 'Nirma Patel'}
    * method POST
    * print response
    * status 200
#    Here, we haven't received response json with 'successfully added' message. Ideally endpoint should return unsuccessful status code.
    * match response == ''
#    For double verification, try to get the book by ID. Should receive failure status code
    * path getBookPath
    * param ID = aisleNo
    * method GET
    * print response
    * status 404
    * match response == { "msg": "The book by requested bookid / author name does not exists!"}

  Scenario: Add new book without aisle
    * path addBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { name: 'Learn API testing with karate - Part 2', isbn: '#(isbnNo)', author: 'Nirma Patel'}
    * method POST
    * print response
    * status 200
#    Here, we haven't received response json with 'successfully added' message. Ideally endpoint should return unsuccessful status code.
    * match response == ''
#    For double verification, try to get the book by ID. Should receive failure status code
    * path getBookPath
    * param ID = isbnNo
    * method GET
    * print response
    * status 404
    * match response == { "msg": "The book by requested bookid / author name does not exists!"}

  Scenario: Add existing book with the same details again
#    Add new book
    * path addBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { name: 'Learn API testing with karate', isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * method POST
    * print response
    * status 200
    * match response == {ID: '#(isbnNo + aisleNo)', Msg: 'successfully added' }
#    Try to add the same book again
    * path addBookPath
    * header Accept = 'application/json'
    * request { name: 'Learn API testing with karate', isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * method POST
    * print response
#    Verify negative response
    * status 404
    * match response == {"msg":"Add Book operation failed, looks like the book already exists"}
#     CleanUp
    * path deleteBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { ID: '#(isbnNo + aisleNo)' }
    * method POST
    * print response
    * status 200
    * match response == { "msg": "book is successfully deleted" }
    
  Scenario: Add existing book with the same isbn and aisle again
#    Add new book
    * path addBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { name: 'Learn API testing with karate - Part 2', isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * method POST
    * print response
    * status 200
    * match response == {ID: '#(isbnNo + aisleNo)', Msg: 'successfully added' }
#    Try to add the same book again
    * path addBookPath
    * header Accept = 'application/json'
    * request { name: 'Learn API testing with karate - Part 3', isbn: '#(isbnNo)', aisle: '#(aisleNo)', author: 'Nirma Patel' }
    * method POST
    * print response
#    Verify negative response
    * status 404
    * match response == {"msg":"Add Book operation failed, looks like the book already exists"}
#     CleanUp
    * path deleteBookPath
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * request { ID: '#(isbnNo + aisleNo)' }
    * method POST
    * print response
    * status 200
    * match response == { "msg": "book is successfully deleted" }
