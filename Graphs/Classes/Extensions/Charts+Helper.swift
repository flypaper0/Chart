//
//  Charts+Helper.swift
//  Graphs
//
//  Created by Artur Guseinov on 13/01/2019.
//  Copyright © 2019 Artur Guseinov. All rights reserved.
//

import Foundation
import Charts

extension LineChartView {
  
  func configure(dataSet: LineChartDataSet) {
    
    let strokeColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
    let fillColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)
    let textColor = UIColor(red: 0.78, green: 0.8, blue: 0.83, alpha: 1.0)
    let highlightColor = UIColor(red: 1.0, green: 0.32, blue: 0.32, alpha: 1.0)
    
    let data = LineChartData()
    data.addDataSet(dataSet)
    
    dataSet.mode = .cubicBezier
    dataSet.drawCirclesEnabled = false
    dataSet.colors = [strokeColor]
    dataSet.drawFilledEnabled = true
    dataSet.fillColor = fillColor
    dataSet.fillAlpha = 1.0
    dataSet.lineWidth = 1.0
    dataSet.highlightColor = highlightColor
    dataSet.drawHorizontalHighlightIndicatorEnabled = false
    dataSet.highlightLineWidth = 1.0
    
    minOffset = 0
    legend.enabled = false
    chartDescription?.enabled = false
    gridBackgroundColor = .clear
    drawGridBackgroundEnabled = true
    pinchZoomEnabled = false
    doubleTapToZoomEnabled = false
    scaleXEnabled = false
    scaleYEnabled = false
    leftAxis.enabled = false
    rightAxis.gridLineDashLengths = [8, 4]
    rightAxis.gridColor = strokeColor
    rightAxis.gridLineWidth = 1.0
    rightAxis.drawLimitLinesBehindDataEnabled = false
    rightAxis.labelTextColor = textColor
    rightAxis.labelPosition = .insideChart
    rightAxis.zeroLineColor = .clear
    rightAxis.yOffset = -7.0
    xAxis.labelPosition = .bottomInside
    xAxis.labelTextColor = textColor
    xAxis.drawGridLinesEnabled = false
    xAxis.avoidFirstLastClippingEnabled = true
    xAxis.spaceMax = 0
    
    self.data = data
  }
  
}

