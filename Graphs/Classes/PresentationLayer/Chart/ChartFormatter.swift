//
//  ChartFormatter.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import Foundation
import Charts

class ChartFormatter: IAxisValueFormatter {
  
  let timescale: ChartTimescale
  
  init(timescale: ChartTimescale) {
    self.timescale = timescale
  }
  
  public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let date = Date(timeIntervalSince1970: value)
    let formatter = DateFormatter()
    formatter.dateFormat = timescale.formatter
    formatter.locale = Locale.current
    return formatter.string(from: date)
  }
}
