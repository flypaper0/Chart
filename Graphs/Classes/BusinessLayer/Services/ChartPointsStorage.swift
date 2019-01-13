//
//  ChartPointsStorage.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import Foundation

protocol ChartPointsStorageProtocol {
  var points: [ChartPoint] { get }
}

class ChartPointsStorage: ChartPointsStorageProtocol {
  
  lazy var points: [ChartPoint] = {
    let startDate = DateComponents(calendar: .current, year: 2016, month: 1, day: 1).date!
    let step = DateComponents(minute: 30)
    let timeDay = TimeDay(startDate: startDate, endDate: Date(), step: step)
    
    let points = timeDay.timeIntervals.map { date -> ChartPoint in
      let yield = arc4random_uniform(30)
      let price = arc4random_uniform(200)
      return ChartPoint(date: date, yield: Double(yield), price: Double(price))
    }
    
    return points
  }()
  
}
