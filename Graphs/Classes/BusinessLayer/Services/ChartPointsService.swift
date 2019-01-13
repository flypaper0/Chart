//
//  ChartPointsService.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import Foundation

protocol ChartPointsServiceDelegate: class {
  func didReceivePoints(_ points: [ChartPoint], timescale: ChartTimescale)
}

protocol ChartPointsServiceProtocol {
  func getPoints(isin: String, timescale: ChartTimescale)
}

class ChartPointsService: ChartPointsServiceProtocol {
  
  weak var delegate: ChartPointsServiceDelegate?
  
  let storage: ChartPointsStorageProtocol
  
  init(storage: ChartPointsStorageProtocol, delegate: ChartPointsServiceDelegate?) {
    self.storage = storage
    self.delegate = delegate
  }
  
  func getPoints(isin: String, timescale: ChartTimescale) {
    
    DispatchQueue.global().async { [weak self] in
      
      guard let `self` = self else { return }
      
      var date: Date!
      let calendar = Calendar.current
      
      switch timescale {
      case .hour:
        date = calendar.date(byAdding: .hour, value: -1, to: Date())
      case .day:
        date = calendar.date(byAdding: .day, value: -1, to: Date())
      case .week:
        date = calendar.date(byAdding: .day, value: -7, to: Date())
      case .month:
        date = calendar.date(byAdding: .month, value: -1, to: Date())
      case .year:
        date = calendar.date(byAdding: .year, value: -1, to: Date())
      case .all:
        date = Date.distantPast
      }
      
      let points = self.storage.points.filter { $0.date > date }
      let screening = ceil(Float(points.count) / 20)
      let screened = points.enumerated()
        .filter { $0.offset % Int(screening) == 0 }
        .map { $0.element }
      
      DispatchQueue.main.async {
        self.delegate?.didReceivePoints(screened, timescale: timescale)
      }
      
    }

  }
  
}
