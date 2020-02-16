//
//  NetworkingTests.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 12.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import XCTest
@testable import Countries

class NetworkingTests: XCTestCase {

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

    func test_RCNetworker_getAll_returnsCountries() {
        guard let request = networker.createUrlRequest(from: RCApi.fetchAll) else {
            fatalError("❌ Unable to create request.")
        }
        
        do {
            try RCNetworkingHelper().prepareTest(request: request, fileName: "allCountries")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        let expectation = XCTestExpectation()
        
        let cancellable = networker.fetchAll()
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            }) { (countries) in
                XCTAssertEqual(countries.count, 3)
                
                XCTAssertEqual(countries.first?.alpha3Code, "AFG")
                XCTAssertEqual(countries.first?.name, "Afghanistan")
                
                XCTAssertEqual(countries[1].alpha3Code, "ALA")
                XCTAssertEqual(countries[1].name, "Åland Islands")
                
                XCTAssertEqual(countries.last?.alpha3Code, "ALB")
                XCTAssertEqual(countries.last?.name, "Albania")
                
                expectation.fulfill()
        }
        
        XCTAssertNotNil(cancellable)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_RCNetworker_getOne_returnsCountry() {
        let api = RCApi.fetch(id: "AFG")
        guard let request = networker.createUrlRequest(from: api) else {
            fatalError("❌ Unable to create request.")
        }
        
        do {
            try RCNetworkingHelper().prepareTest(request: request, fileName: "oneCountry")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        let expectation = XCTestExpectation()
        
        let cancellable = networker.fetch(id: "AFG")
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            }) { (country) in
                XCTAssertEqual(country.alpha3Code, "AFG")
                XCTAssertEqual(country.name, "Afghanistan")
                
                expectation.fulfill()
        }
        
        XCTAssertNotNil(cancellable)
        wait(for: [expectation], timeout: 5.0)
    }
}
