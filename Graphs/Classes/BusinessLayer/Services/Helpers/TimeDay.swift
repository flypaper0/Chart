//
//  TimeDay.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import Foundation


struct TimeDay {
  let startDate: Date
  let endDate: Date
  let step: DateComponents
  
  var calendar = Calendar.autoupdatingCurrent
  
  init(startDate: Date, endDate: Date, step: DateComponents) {
    self.startDate = startDate
    self.endDate = endDate
    self.step = step
  }
  
  var timeIntervals : [Date] {
    guard startDate <= endDate else {
      return []
    }
    
    var result = [startDate]
    var date = startDate
    while date < endDate {
      date = calendar.date(byAdding: step, to: date)!
      result.append(date)
    }
    
    return result
  }
}
