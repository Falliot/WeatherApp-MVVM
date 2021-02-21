//
//  WeatherDataTest.swift
//  WeatherTests
//
//  Created by Anton on 2/21/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherDataTest: XCTestCase {

  var exampleJSONData: Data!
  var weather: WeatherModel!

  override func setUp() {
    let bundle = Bundle(for: type(of: self))
    let url = bundle.url(forResource: "WeatherExample", withExtension: "json")!
    exampleJSONData = try! Data(contentsOf: url)
  
    let decoder = JSONDecoder()
    weather = try! decoder.decode(WeatherModel.self, from: exampleJSONData)
  }
  
  func testDecodeCity() throws {
    XCTAssertEqual(weather.data.request.first?.query, "Gliwice, Poland")
  }
  
  func testDecodeMaxTemp() throws {
    XCTAssertEqual(weather.data.weather.first?.maxtempC, "7")
  }
  
  func testDecodeMinTemp() throws {
    XCTAssertEqual(weather.data.weather.first?.mintempC, "1")
  }
  
  func testDecodeDate() throws {
    XCTAssertEqual(weather.data.weather.first?.date, "2021-02-21")
  }
  
  func testDecodeIcon() throws {
    XCTAssertEqual(weather.data.weather.first?.hourly.first?.weatherIconUrl.first?.value, "http://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png")
  }
}
