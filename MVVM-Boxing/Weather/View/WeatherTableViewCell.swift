//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
  
  /// Outlets
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var iconImg: UIImageView!
  @IBOutlet weak var maxLabel: UILabel!
  @IBOutlet weak var minLabel: UILabel!
  
  /// Cell identifier
  static let identifier = "weatherCell"
  
  /// A method that returns UINib
  static func nib() -> UINib {
    return UINib(nibName: "WeatherTableViewCell", bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  /// A method for configuring cell contents
  /// - Parameter weather: requires WeatherModel object
  func configureCell(with viewModel: WeatherViewModel) {
    
    viewModel.day.bind { [weak self] day in
      self?.dayLabel.text = day
    }
    
    viewModel.iconURL.bind { [weak self] iconURL in
      self?.iconImg.imageDownloader(from: iconURL)
    }
    
    viewModel.maxTemp.bind { [weak self] maxTemp in
      self?.maxLabel.text = maxTemp
    }
    
    viewModel.minTemp.bind { [weak self] minTemp in
      self?.minLabel.text = minTemp
    }
  }
}
