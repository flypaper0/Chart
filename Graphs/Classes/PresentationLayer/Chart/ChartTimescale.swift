//
//  ChartTimescale.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import Foundation

enum ChartTimescale: Int, CaseIterable {
  case hour = 1
  case day
  case week
  case month
  case year
  case all
  
  var formatter: String {
    switch self {
    case .hour:
      return "H:mm"
    case .day:
      return "H:mm"
    case .week:
      return "E"
    case .month:
      return "MMM d"
    case .year:
      return "MMM"
    case .all:
      return "Y"
    }
  }
}
