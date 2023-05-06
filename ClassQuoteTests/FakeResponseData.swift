//
//  FakeResponseData.swift
//  ClassQuoteTests
//
//  Created by Lilian MAGALHAES on 2023-04-14.
//

import Foundation
class FakeResponseData {
    static let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class QuoteError: Error {}
    static let error = QuoteError()
    static var quoteCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Quote", withExtension: "json")
        let data =  try! Data(contentsOf: url!)
        return data
    }
    
    static let quoteIncorrectData = "erreur".data(using: .utf8)!
    static let imageData = "image".data(using: .utf8)!
        
}
