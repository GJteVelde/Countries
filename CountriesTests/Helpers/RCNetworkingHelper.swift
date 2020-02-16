//
//  RCNetworkingHelper.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import Foundation
@testable import Countries

enum NetworkingHelperError: Error {
    case fileNotFound(name: String)
    case unableToCreateStringFromFile
    case unableToCreateDataFromString
    case invalidHTTPURLResponse
    case invalidURL
}

class RCNetworkingHelper {
    
    /// Initializes a `RCNetworker` object that uses the `URLProtocolMock`. Use `prepareTest(request: fileName:)` to insert the appropriate data for the request being tested.
    func createRCNetworkingMock() -> RCNetworker {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        return RCNetworker(session: session)
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

extension RCNetworkingHelper {
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
