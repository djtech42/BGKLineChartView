//
//  BGKChartPoint.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

/// Protocol that defines the interface for an object that can provide points for a chart.
public protocol BGKPointRepresentable {
    var xValue: Double { get }
    var yValue: Double { get }
}

public struct BGKBasicPoint: BGKPointRepresentable {
    public var xValue: Double
    public var yValue: Double
    
    public init(xValue: Double, yValue: Double) {
        self.xValue = xValue
        self.yValue = yValue
    }
}
