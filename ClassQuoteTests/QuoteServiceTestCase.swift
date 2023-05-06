//
//  QuoteServiceTestCase.swift
//  ClassQuoteTests
//
//  Created by Lilian MAGALHAES on 2023-04-14.
//
@testable import ClassQuote
import XCTest

final class QuoteServiceTestCase: XCTestCase {
    
    class QuoteServiceTestCase: XCTestCase {
        func testGetQuoteShouldPostFailedCallbackIfError() {
            //Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
                imageSession:  URLSessionFake(data: nil, response: nil, error: nil))
            //When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            quoteService.getQuote { success, quote in
                //Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
        
        func testGetQuoteShouldPostFailedCallbackIfNoData() {
            //Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: nil, response: nil, error: nil),
                imageSession:  URLSessionFake(data: nil, response: nil, error: nil))
            //When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            quoteService.getQuote { success, quote in
                //Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
        
        
        func testGetQuoteShouldPostFailedCallbackIfIncorrectResponse() {
            //Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseKO, error: nil),
                imageSession:  URLSessionFake(data: nil, response: nil, error: nil))
            //When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            quoteService.getQuote { success, quote in
                //Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
        
        func testGetQuoteShouldPostFailedCallbackIfIncorrectData() {
            //Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: FakeResponseData.quoteIncorrectData, response: FakeResponseData.responseOk, error: nil),
                imageSession:  URLSessionFake(data: nil, response: nil, error: nil))
            //When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            quoteService.getQuote { success, quote in
                //Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    }
    
    
    func testGetQuoteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        //Given
        let quoteService = QuoteService(
            quoteSession: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseOk, error: nil),
            imageSession:  URLSessionFake(data: FakeResponseData.imageData, response: FakeResponseData.responseOk, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { success, quote in
            //Then
            let text = "He who controls others may be powerful, but he who has mastered himself is mightier still."
            let author = "Lao Tzu "
            let imageData = "image".data(using:  .utf8)!
            
            XCTAssertTrue(success)
            XCTAssertNotNil(quote)
            
            XCTAssertEqual(text, quote!.text)
            XCTAssertEqual(imageData, quote!.imageData)
            XCTAssertEqual(author, quote!.author)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostFailedNotificationIfNoImageData() {
            // Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseOk, error: nil),
                imageSession: URLSessionFake(data: nil, response: nil, error: nil))

            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            quoteService.getQuote { (success, quote) in
                // Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

        func testGetQuoteShouldPostFailedNotificationIfErrorWhileRetrievingImage() {
            // Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseOk, error: nil),
                imageSession: URLSessionFake(data: FakeResponseData.imageData, response: FakeResponseData.responseOk, error: FakeResponseData.error))

            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            quoteService.getQuote { (success, quote) in
                // Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.02)
        }

        func testGetQuoteShouldPostFailedNotificationIfIncorrectResponseWhileRetrievingImage() {
            // Given
            let quoteService = QuoteService(
                quoteSession: URLSessionFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseOk, error: nil),
                imageSession: URLSessionFake(data: FakeResponseData.imageData, response: FakeResponseData.responseKO, error: FakeResponseData.error))

            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            quoteService.getQuote { (success, quote) in
                // Then
                XCTAssertFalse(success)
                XCTAssertNil(quote)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

    
}
    

   /*
    func testDownloadWebData() throws {
        let expectation = XCTestExpectation(description: "Download site oppenclassrooms.com")
        
        let url = URL(string: "https://openclassrooms.com")!
        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, _, _) in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        dataTask.resume()
        
        wait(for: [expectation], timeout: 10.0)
        }
    */
    


