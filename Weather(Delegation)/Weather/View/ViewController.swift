//
//  ViewController.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  /// Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  /// Properties
  var weatherViewModel = [WeatherViewModel]()
  var weatherManager = WeatherManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configuring all delegates
    weatherManager.delegate = self
    searchBar.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
    tableView.separatorStyle = .none
    
    weatherManager.fetchWeatherByCity(cityName: "Gliwice")
  }
  
  /// A method that shows an alert
   func showAlert() {
     DispatchQueue.main.async {
       let alert = UIAlertController(title: "Weather", message: "Not Found", preferredStyle: .alert)
       let action = UIAlertAction(title: "Dismiss", style: .default, handler: .none)
       alert.addAction(action)
       self.present(alert, animated: true, completion: nil)
     }
   }
}

/// Extension with UITableViewDelegate & DataSource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherViewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
    
    let weatherObject = weatherViewModel[indexPath.row]
    
    cell.configureCell(with: weatherObject)
    
    return cell
  }
}

/// Extension with UISearchBarDelegate method
extension ViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if let cityString = searchBar.text, !cityString.isEmpty {
      
      if cityString.contains(" ") {
        let split = cityString.components(separatedBy: " ")
        weatherManager.fetchWeatherByCity(cityName: split[0], cityLastName: split[1])
      } else {
        weatherManager.fetchWeatherByCity(cityName: cityString)
      }
      searchBar.text = ""
      self.tableView.reloadData()
    }
  }
}

/// Extension with WeatherManagerDelegate methods
extension ViewController: WeatherManagerDelegate {

  func didUpdateWeather(weather: [WeatherViewModel]) {
    self.weatherViewModel = weather
    DispatchQueue.main.async {
      self.title = weather.first?.cityName
      self.tableView.reloadData()
    }
    print(weather)
  }
  
  func didFailWithError(error: Error) {
    print(error)
    showAlert()
  }
}
