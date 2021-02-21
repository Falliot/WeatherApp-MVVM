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
  var weatherVM = WeatherViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configuring all delegates
    searchBar.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
    tableView.separatorStyle = .none
    
    self.weatherVM.weather.bind {
      if ($0 != nil) {
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
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
    guard let weather = self.weatherVM.weather.value else { return 0 }
    return weather.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let weather = self.weatherVM.weather.value else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
    
    let weatherObject = weather[indexPath.row]
    
    cell.configureCell(with: weatherObject)
    self.title = weather.first?.cityName.value
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
        weatherVM.fetchWeather(cityName: split[0], cityLastName: split[1]) { (isError) in
          if isError == false {
            self.showAlert()
          }
        }
      } else {
        weatherVM.fetchWeather(cityName: cityString) { (isError) in
          if isError == false {
            self.showAlert()
          }
        }
      }
      searchBar.text = ""
      self.tableView.reloadData()
    }
  }
}
