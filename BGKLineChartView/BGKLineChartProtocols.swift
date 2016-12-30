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

public protocol BGKChartable {
    var values: [BGKLinePoint] { get }
}

public protocol BGKLineChartDataSource: class {
    // MARK: - Methods that Must be Implemented by User
    func numberOfLinesToDraw(_ lineChartView: BGKLineChartView) -> Int
    func allValues(_ lineChartView: BGKLineChartView) -> [BGKChartable]
    func lineChartView(_ lineChartView: BGKLineChartView, pointsForIndex: Int) -> [BGKLinePoint]
    
    // MARK: - Methods with Default Implementations
    func valueExtents(_ lineChartView: BGKLineChartView, forAxis: BGKChartAxis) -> BGKChartExtents
    func lineChartView(_ lineChartView: BGKLineChartView, styleForIndex: Int) -> BGKLineStyle?
    func lineChartView(_ lineChartView: BGKLineChartView, stringForLabel: BGKLineChartViewLabel) -> String?
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool
}

extension BGKLineChartDataSource {
    func valueExtents(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> BGKChartExtents {
        switch axis {
        case .xAxis:
            
        case .yAxis:
        }
    }
    func lineChartView(_ lineChartView: BGKLineChartView, styleForIndex: Int) -> BGKLineStyle? {
        return nil
    }
    func lineChartView(_ lineChartView: BGKLineChartView, stringForLabel: BGKLineChartViewLabel) -> String? {
        return nil
    }
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool {
        return true
    }
}
