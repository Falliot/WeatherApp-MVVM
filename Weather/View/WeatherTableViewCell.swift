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
    dayLabel.text = viewModel.day
    iconImg.imageDownloader(from: viewModel.iconURL)
    maxLabel.text = viewModel.maxTemp
    minLabel.text = viewModel.minTemp
  }
}
