//
//  Box.swift
//  Weather
//
//  Created by Anton on 2/21/21.
//  Copyright © 2021 falli_ot. All rights reserved.
//

import Foundation

/// Box class  that uses property observers to notify observers that a value has changed.
class Box<T> {
  
  /// Each Box can have a Listener that Box notifies when the value changes.
  typealias Listener = (T) -> ()
  
  // MARK:- variables for the binder
  /// Box has a generic type value. The didSet property observer detects any changes and notifies Listener of any value update.
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  var listener: Listener?
  
  // MARK:- initializers for the binder
  /// The initializer sets Box‘s initial value.
  init(_ value: T) {
    self.value = value
  }
  
  // MARK:- functions for the binder
  /// When a Listener calls bind(listener:) on Box, it becomes Listener and immediately gets notified of the Box‘s current value.
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
