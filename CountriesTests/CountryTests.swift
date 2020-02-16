//
//  CountryTests.swift
//  CountriesTests
//
//  Created by Gerrit Jan te Velde on 16.02.20.
//  Copyright © 2020 Gerrit Jan te Velde. All rights reserved.
//

import XCTest
@testable import Countries

class CountryTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }
    
    func test_Country_CorrectDecoding() {
        
        do {
            let data = try RCNetworkingHelper().dataFromFile("oneCountry")
            let country = try JSONDecoder().decode(Country.self, from: data)
            
            XCTAssertEqual(country.alpha3Code, "AFG")
            XCTAssertEqual(country.id, "AFG")
            XCTAssertEqual(country.name, "Afghanistan")
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
