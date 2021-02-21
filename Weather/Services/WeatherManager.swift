//
//  WeatherManager.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import UIKit

/// WeatherManager is resposible for the networking part
struct WeatherManager {
  
  /// URL
  private let weatherURL = "https://api.worldweatheronline.com/premium/v1/weather.ashx?cc=no&mca=no&tp=24&num_of_days=10&format=json&key="
  
  /// API key
  private let API_KEY = "2fb65054e53f45169c3141158211802"
  
  /// A method for retrieving the weather
  /// - Parameter cityName: first part of the city name
  /// - Parameter cityLastName: second part of the city name
  /// - Parameter completionHandler: a callback with results
  func fetchWeatherByCity(_ cityName: String, _ cityLastName: String?, completionHandler: @escaping (Result<WeatherModel?, Error>) -> ()) {
    let urlString = "\(weatherURL)\(API_KEY)&q=\(cityName)+\(cityLastName ?? "")"
    performRequest(with: urlString) { result in
      completionHandler(result)
    }
  }
  
  
  /// A method that performs the request
  /// - Parameter urlString: url as a string
  /// - Parameter completionHandler: a callback with results
  private func performRequest(with urlString: String, completionHandler: @escaping (Result<WeatherModel?, Error>) -> ()) {
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      if error != nil {
        completionHandler(.failure(error!))
        return
      }
      
      if let safeData = data {
        if let weather = self.parseJSON(safeData) {
          completionHandler(.success(weather))
        }
      }
    }.resume()
  }
  
  /// Method for parsing the JSON
  /// - Parameter weatherData: Data object
  /// - Returns: Optional WeatherModel array
  private func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
      return decodedData
    } catch {
      print(error)
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
