//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import Foundation

struct WeatherViewModel {
  
  /// Properties
  var weatherManager = WeatherManager()
  
  let weather: Box<[WeatherViewModel]?> = Box(nil)
  
  let cityName = Box("Loading...")
  let day = Box(" ")
  let maxTemp = Box(" ")
  let minTemp = Box(" ")
  let iconURL = Box(" ")
  
  private let defaultLocation = "Gliwice"
  
  /// Init method
  init(weatherManager: WeatherManager = WeatherManager()) {
    self.weatherManager = weatherManager
    
    fetchWeather(cityName: defaultLocation)
  }
  
  /// Init method
  /// - Parameter completionHandler: a callback with results
  init(cityName: Request, weather: Weather) {
    self.cityName.value = cityName.query
    day.value = Utility.dayFromDate(currentDate: weather.date)!
    maxTemp.value = weather.maxtempC
    minTemp.value = weather.mintempC
    iconURL.value = weather.hourly.first!.weatherIconUrl.first!.value
  }
  
  /// A method fetching/setting the data
  /// - Parameter cityName: takes a string
  /// - Parameter cityLastName: takes a string if it's needed (ex. New York, two part city name)
  /// - Parameter completion: a callback returning a bool
  func fetchWeather(cityName: String, cityLastName: String = "", completion: ((_ success: Bool) -> Void)? = nil) {
    var weatherModel = [WeatherViewModel]()
    
    weatherManager.fetchWeatherByCity(cityName, cityLastName) { result in
      switch result {
      case.success(let weatherResponse):
        
        if weatherResponse!.data.error == nil {
          guard let weatherResponse = weatherResponse else { return }
          
          let cityName = weatherResponse.data.request!.first!
          
          for weather in weatherResponse.data.weather! {
            weatherModel.append(WeatherViewModel(cityName: cityName, weather: weather))
          }
          self.weather.value = weatherModel
        } else {
          completion!(false)
        }
      case.failure(let error):
        print(error)
      }
    }
  }
}
