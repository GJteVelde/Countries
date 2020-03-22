//
//  CountryUnitTests.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import XCTest
@testable import Countries

class CountryUnitTests: XCTestCase {

    var networker: Networker!
    var countryRemoteStore: CountryRemoteStore!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        networker = Networker(session: session)
        countryRemoteStore = CountryRemoteStore(networking: networker)
    }

    override func tearDown() {
        networker = nil
        countryRemoteStore = nil
    }
    
    //MARK: - RestCountries API Tests
    
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
    
    //MARK: - CountryRemoteStore Tests
    
    func test_countryRemoteStore_getAll() {
        guard let request = networker.createUrlRequest(from: RCApi.fetchAll) else {
            fatalError("❌ Failure creating creating request.")
        }
        
        do {
            try NetworkingHelper().prepareTest(request: request, fileName: "allCountries")
        } catch {
            fatalError("❌ Error preparing test: \(error.localizedDescription).")
        }
        
        let expectation = XCTestExpectation()
        
        let cancellable = countryRemoteStore.getAll()
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
}
