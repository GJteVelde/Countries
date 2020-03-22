//
//  FlagUnitTests.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 21.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import XCTest
@testable import Countries

class FlagUnitTests: XCTestCase {

    var networker: Networker!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        networker = Networker(session: session)
    }

    override func tearDown() {
        networker = nil
    }
}

extension FlagUnitTests {
    
    func test_CFApi_fetchFlag_returnNl() {
        let id = "nl"
        let api = CFApi.fetchFlag(id: id)
        
        let request = networker.createUrlRequest(from: api)
        
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "countryflags.io")
        XCTAssertEqual(request?.url?.path, "/\(id)/shiny/64.png")
        
        XCTAssertNotEqual(request?.url?.path, "/de/shiny/64.png")
    }

    func test_CFApi_fetchFlag_returnDe() {
        let id = "de"
        let api = CFApi.fetchFlag(id: id)
        
        let request = networker.createUrlRequest(from: api)
        
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "countryflags.io")
        XCTAssertEqual(request?.url?.path, "/\(id)/shiny/64.png")
        
        XCTAssertNotEqual(request?.url?.path, "/nl/shiny/64.png")
    }
}
