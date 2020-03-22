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
            let data = try NetworkingHelper().dataFromFile("oneCountry")
            let country = try JSONDecoder().decode(Country.self, from: data)
            
            XCTAssertEqual(country.id, country.alpha3Code)
            XCTAssertEqual(country.alpha3Code, "AFG")
            XCTAssertEqual(country.alpha2Code, "AF")
            XCTAssertEqual(country.id, "AFG")
            XCTAssertEqual(country.name, "Afghanistan")
            XCTAssertEqual(country.capital, "Kabul")
            XCTAssertEqual(country.region, "Asia")
            XCTAssertEqual(country.subregion, "Southern Asia")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func test_CountryRealm_Correct() {
        
        do {
            let data = try NetworkingHelper().dataFromFile("oneCountry")
            let country = try JSONDecoder().decode(Country.self, from: data)
            
            let countryRealm = country.toStorable()
            
            XCTAssertEqual(countryRealm.id, "AFG")
            XCTAssertEqual(countryRealm.alpha3Code, "AFG")
            XCTAssertEqual(countryRealm.alpha2Code, "AF")
            XCTAssertEqual(countryRealm.name, "Afghanistan")
            XCTAssertEqual(countryRealm.capital, "Kabul")
            XCTAssertEqual(countryRealm.region, "Asia")
            XCTAssertEqual(countryRealm.subregion, "Southern Asia")
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }

}
