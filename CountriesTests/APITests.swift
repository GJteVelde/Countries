//
//  APITests.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import XCTest
@testable import Countries

class APITests: XCTestCase {

    var networker: RCNetworker!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        networker = RCNetworker(session: session)
    }

    override func tearDown() {
        networker = nil
    }
    
    func test_RCAPI_fetchAll_correctAPI() {
        let api = RCApi.fetchAll
        
        let request = networker.createUrlRequest(from: api)
        
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "restcountries.eu")
        XCTAssertEqual(request?.url?.path, "/rest/v2/all")
    }

    func test_RCAPI_fetchId_correctAPI() {
        let api = RCApi.fetch(id: "AFG")
        
        let request = networker.createUrlRequest(from: api)
        
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "restcountries.eu")
        XCTAssertEqual(request?.url?.path, "/rest/v2/alpha/AFG")
    }
}
