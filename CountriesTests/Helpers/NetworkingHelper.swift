//
//  NetworkingHelper.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
import SwiftUI
@testable import Countries

enum NetworkingHelperError: Error {
    case fileNotFound(name: String)
    case unableToCreateStringFromFile
    case unableToCreateDataFromString
    case invalidHTTPURLResponse
    case invalidURL
}

class NetworkingHelper {
    
    /// Creates and returns a URLSession for testing purposes. Add data to the `URLProtocolMock` via `prepareTest(request: fileName:)`.
    func createURLSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
    
    /// Inserts the data of the file in the URLProtocolMock.
    /// - Parameters:
    ///   - request: The request used to fetch data. This request should be the same as the real request.
    ///   - fileName: The name of the file of type `.json` that contains the data you want to return.
    func prepareTest(request: URLRequest, fileName: String) throws {
        guard let url = request.url else {
            throw NetworkingHelperError.invalidURL
        }
        
        do {
            let data = try returnDataFromFile(fileName)
            
            URLProtocolMock.requestHandler = { request in
                guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
                    throw NetworkingHelperError.invalidHTTPURLResponse
                }
                return (response, data)
            }
        } catch {
            throw error
        }
    }
    
    func dataFromFile(_ fileName: String) throws -> Data {
        do {
            return try returnDataFromFile(fileName)
        } catch {
            throw error
        }
    }
}

extension NetworkingHelper {
    private func returnDataFromFile(_ fileName: String) throws -> Data {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            throw NetworkingHelperError.fileNotFound(name: fileName)
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            throw NetworkingHelperError.unableToCreateStringFromFile
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            throw NetworkingHelperError.unableToCreateDataFromString
        }
        
        return data
    }
}
