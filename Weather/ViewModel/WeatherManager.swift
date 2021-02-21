//
//  WeatherManager.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import UIKit

/// Methods for passing the data and dealing with errors
protocol WeatherManagerDelegate {
  /// A method for passing the weather data
  /// - Parameter weather: requires a WeatherModel array
  func didUpdateWeather(weather: [WeatherViewModel])
  
  /// An error method
  /// - Parameter error: requires an error object
  func didFailWithError(error: Error)
}

/// WeatherManager is resposible for the networking part
struct WeatherManager {
  
  /// URL
  private let weatherURL = "https://api.worldweatheronline.com/premium/v1/weather.ashx?cc=no&mca=no&tp=24&num_of_days=10&format=json&key="
  
  /// API key
  private let API_KEY = "2fb65054e53f45169c3141158211802"
  
  /// WeatherManagerDelegate object
  var delegate: WeatherManagerDelegate?
  
  /// A method for retrieving the weather
  /// - Parameter cityName: String as input
  func fetchWeatherByCity(cityName: String) {
    let urlString = "\(weatherURL)\(API_KEY)&q=\(cityName)"
    performRequest(with: urlString)
  }
  
  /// A method for retrieving the weather (in case the city name consits of two words. Ex. "New York")
  /// - Parameter cityName: first part of the city name
  /// - Parameter cityLastName: second part of the city name
  func fetchWeatherByCity(cityName: String, cityLastName: String) {
    let urlString = "\(weatherURL)\(API_KEY)&q=\(cityName)+\(cityLastName)"
    performRequest(with: urlString)
  }
  
  
  /// A method that performs the request
  /// - Parameter urlString: url as a string
  private func performRequest(with urlString: String) {
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      if error != nil {
        self.delegate?.didFailWithError(error: error!)
        return
      }
      
      if let safeData = data {
        if let weather = self.parseJSON(safeData) {
          self.delegate?.didUpdateWeather(weather: weather)
        }
      }
    }.resume()
  }
  
  /// Method for parsing the JSON
  /// - Parameter weatherData: Data object
  /// - Returns: Optional WeatherModel array
  private func parseJSON(_ weatherData: Data) -> [WeatherViewModel]? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
      
      var weatherModel = [WeatherViewModel]()
      
      let cityName = decodedData.data.request.first!
      
      for weather in decodedData.data.weather {
        weatherModel.append(WeatherViewModel(cityName: cityName, weather: weather))
      }
      return weatherModel
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
}

/// Extension for the UIImageView
extension UIImageView {
  /// A method for downloading the image
  /// - Parameter urlString: URL as a string
  func imageDownloader(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    guard let url = URL(string: urlString) else { return }
    performImageRequest(from: url, contentMode: mode)
  }
  
  /// A method for performing the request
  /// - Parameter url: Image URL
  func performImageRequest(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
      }
    }.resume()
  }
}
