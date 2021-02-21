//
//  WeatherModel.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import Foundation

/// Weather Data that comes from the API
struct WeatherModel: Codable {
  let data: WeatherData
}

struct WeatherData: Codable {
  let request: [Request]
  let weather: [Weather]
}

struct Request: Codable {
  let query: String
}

struct Weather: Codable {
  let date: String
  let maxtempC: String
  let mintempC: String
  let hourly: [Hourly]
}

struct Hourly: Codable {
  let weatherIconUrl: [WeatherIcon]
}

struct WeatherIcon: Codable {
  let value: String
}
