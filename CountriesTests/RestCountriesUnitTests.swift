//
//  RestCountriesUnitTests.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import XCTest
@testable import Countries

class RestCountriesUnitTests: XCTestCase {

    var networker: CountriesNetworker!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        networker = CountriesNetworker(session: session)
    }

    override func tearDown() {
        networker = nil
    }
    
    func test_RCAPI_fetchAll() {
        let api = RCApi.fetchAll
        
        let request = networker.createUrlRequest(from: api)
        
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "restcountries.eu")
        XCTAssertEqual(request?.url?.path, "/rest/v2/all")
    }

    func test_RCAPI_fetchId_afg() {
        let api = RCApi.fetch(id: "AFG")
        
        let request = networker.createUrlRequest(from: api)
        
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "restcountries.eu")
        XCTAssertEqual(request?.url?.path, "/rest/v2/alpha/AFG")
    }
    
    func test_RCNetworker_getAll() {
        guard let request = networker.createUrlRequest(from: RCApi.fetchAll) else {
            fatalError("❌ Failure creating creating request.")
        }
        
        do {
            try NetworkingHelper().prepareTest(request: request, fileName: "allCountries")
        } catch {
            fatalError("❌ Error preparing test: \(error.localizedDescription).")
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
                
                XCTAssertNotEqual(countries.last?.alpha3Code, "NL")
                XCTAssertNotEqual(countries.last?.name, "Netherlands")
                
                expectation.fulfill()
            }
        
        XCTAssertNotNil(cancellable)
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_RCNetworker_getById_afg() {
        let api = RCApi.fetch(id: "AFG")
        guard let request = networker.createUrlRequest(from: api) else {
            fatalError("❌ Failure creating creating request.")
        }
        
        do {
            try NetworkingHelper().prepareTest(request: request, fileName: "oneCountry")
        } catch {
            fatalError("❌ Error preparing test: \(error.localizedDescription).")
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
                
                XCTAssertNotEqual(country.alpha3Code, "NL")
                XCTAssertNotEqual(country.name, "Netherlands")
                
                expectation.fulfill()
        }
        
        XCTAssertNotNil(cancellable)
        wait(for: [expectation], timeout: 2.0)
    }
}
