//
//  BGKLineChartProtocols.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public protocol BGKLinePoint {
    var xValue: Double { get }
    var yValue: Double { get }
}

public protocol BGKLineChartDataSource: class {
    func numberOfLinesToDraw(_ lineChartView: BGKLineChartView) -> Int
    func valueExtents(_ lineChartView: BGKLineChartView, forAxis: BGKChartAxis) -> BGKChartAxisExtents
    func lineChartView(_ lineChartView: BGKLineChartView, pointsForIndex: Int) -> [BGKLinePoint]
    func lineChartView(_ lineChartView: BGKLineChartView, styleForIndex: Int) -> BGKLineStyle?
    func lineChartView(_ lineChartView: BGKLineChartView, stringForLabel: BGKLineChartViewLabel) -> String?
}

extension BGKLineChartDataSource {
    func lineChartView(_ lineChartView: BGKLineChartView, stringForLabel: BGKLineChartViewLabel) -> String? {
        return nil
    }
}
