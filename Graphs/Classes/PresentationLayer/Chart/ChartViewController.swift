//
//  ChartViewController.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import UIKit
import Charts

enum DisplayParameter: Int {
  case yield = 0
  case price
}

class ChartViewController: UIViewController {
  @IBOutlet var chartView: LineChartView!
  @IBOutlet var timescaleView: UIView!
  @IBOutlet var timescaleConstraint: NSLayoutConstraint!
  @IBOutlet var timescaleButtons: [UIButton]!
  
  var identifier: String = "ISIN"
  var timescale: ChartTimescale = .hour
  var points: [ChartPoint] = [] {
    didSet {
      update()
    }
  }
  var mode: DisplayParameter = .yield {
    didSet {
      update()
    }
  }
  
  var chartsService: ChartPointsServiceProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let storage = ChartPointsStorage()
    chartsService = ChartPointsService(storage: storage, delegate: self)
    
    chartsService.getPoints(isin: identifier, timescale: timescale)
  }
  
  // MARK: Privates
  
  private func update() {
    updateChart(points: points, timescale: timescale, mode: mode)
  }
  
  private func set(timescale: ChartTimescale, animated: Bool) {
    timescaleConstraint.constant = timescaleButtons.first!.frame.width * CGFloat(timescale.rawValue - 1)
    
    if animated {
      UIView.animate(withDuration: 0.2) {
        self.view.layoutIfNeeded()
      }
    } else {
      self.view.layoutIfNeeded()
    }
  }
  
  private func dequeueParameter(_ mode: DisplayParameter, from points: [ChartPoint]) -> [ChartDataEntry] {
    switch mode {
    case .price:
      return points.map { ChartDataEntry(x: $0.date.timeIntervalSince1970, y: $0.price) }
    case .yield:
      return points.map { ChartDataEntry(x: $0.date.timeIntervalSince1970, y: $0.yield) }
    }
  }
  
  private func updateChart(points: [ChartPoint], timescale: ChartTimescale, mode: DisplayParameter) {
    guard !points.isEmpty else {
      return
    }
    
    let lineChartEntries = dequeueParameter(mode, from: points)
    let dataSet = LineChartDataSet(values: lineChartEntries, label: nil)
    chartView.configure(dataSet: dataSet)
    
    let formatter = ChartFormatter(timescale: timescale)
    chartView.xAxis.valueFormatter = formatter
    
    chartView.highlightValue(nil)
  }
  
  // MARK: - Actions
  
  @IBAction func timescalePressed(_ sender: UIButton) {
    guard let timescale = ChartTimescale(rawValue: sender.tag) else {
      return
    }
    self.timescale = timescale
    set(timescale: timescale, animated: true)
    chartsService.getPoints(isin: identifier, timescale: timescale)
  }
  
  @IBAction func fieldValueChanged(_ sender: UISegmentedControl) {
    guard let mode = DisplayParameter(rawValue: sender.selectedSegmentIndex) else {
      return
    }
    self.mode = mode
  }
  
}


// MARK: - ChartPointsServiceDelegate

extension ChartViewController: ChartPointsServiceDelegate {
  
  func didReceivePoints(_ points: [ChartPoint], timescale: ChartTimescale) {
    self.points = points
  }
  
}
