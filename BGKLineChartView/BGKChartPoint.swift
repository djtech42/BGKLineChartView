//
//  BGKChartPoint.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

/// Protocol that defines the interface for an object that can provide points for a chart.
public protocol BGKChartPoint {
    var xValue: Double { get }
    var yValue: Double { get }
}
