//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import Foundation

struct WeatherViewModel {
  let cityName: String
  let day: String
  let maxTemp: String
  let minTemp: String
  let iconURL: String
  
  init(cityName: Request, weather: Weather) {
    self.cityName = cityName.query
    day = Utility.dayFromDate(currentDate: weather.date)!
    maxTemp = weather.maxtempC
    minTemp = weather.mintempC
    iconURL = weather.hourly.first!.weatherIconUrl.first!.value
  }
}
