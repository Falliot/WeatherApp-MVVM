//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Anton on 2/21/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import XCTest
@testable import Weather
class WeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
  
  func testWeatherViewModel() {
    let request = Request(query: "Warsaw")
    let weatherIcon = WeatherIcon(value: "http://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png")
    let hourly = Hourly(weatherIconUrl: [weatherIcon])
    let weather = Weather(date: "2021-02-21",
                          maxtempC: "1",
                          mintempC: "-1",
                          hourly: [hourly]
    )
    
    let weatherViewModel = WeatherViewModel(cityName: request, weather: weather)
    
    XCTAssertEqual(Utility.dayFromDate(currentDate: weather.date), weatherViewModel.day.value)
    XCTAssertEqual(weather.maxtempC, weatherViewModel.maxTemp.value)
    XCTAssertEqual(weather.mintempC, weatherViewModel.minTemp.value)
    XCTAssertEqual(weather.hourly.first?.weatherIconUrl.first?.value, weatherViewModel.iconURL.value)
  }

}
