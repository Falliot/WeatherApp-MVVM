//
//  Utility.swift
//  Weather
//
//  Created by Anton on 2/19/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import UIKit

/// Utility structure 
struct Utility {
  /// A method to get a current day from the date in "yyyy-MM-dd" format
  /// - Parameter currentDate: Date in  "yyyy-MM-dd" format
  /// - Returns: Returns a day
  static func dayFromDate(currentDate: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let currentDateAsDate = dateFormatter.date(from: currentDate) else { return nil }
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: currentDateAsDate)
  }
}
