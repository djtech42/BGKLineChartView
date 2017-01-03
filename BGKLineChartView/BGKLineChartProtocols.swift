//
//  BGKLineChartProtocols.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public typealias BGKLine = [BGKLinePoint]

/// Protocol that defines the interface for an object that can provide points for BGKLineChart.
public protocol BGKLinePoint {
    var xValue: Double { get }
    var yValue: Double { get }
}

/// Protocol that defines the interface for a group of points that create a chartable object.
public protocol BGKChartable {
    var values: [BGKLinePoint] { get }
}


/// Main protocol that defines the interface for a BGKLineChartDataSource. Two methods make up the required interface for this object: numberOfLinesToDraw(in: BGKLineChartView) and points(thatForm: Int, in: BGKLineChartView). Additional methods provide further cusomization for the data source.
public protocol BGKLineChartDataSource: class {
    
    // MARK: - Methods that Must be Implemented by User
    
    
    /// Tells the line chart how many line objects are to be drawn.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: Integer value of number of chart objects.
    func numberOfLinesToDraw(in lineChartView: BGKLineChartView) -> Int
    /// Provides line points for the chart at an index.
    ///
    /// - Parameters:
    ///   - lineNumber: index of chart object
    ///   - lineChartView: line chart object
    /// - Returns: Array of line point objects
    func points(thatForm lineNumber: Int, in lineChartView: BGKLineChartView) -> [BGKLinePoint]
    
    // MARK: - Methods with Default Implementations
    
    /// Method responsible for providing styling for line chart object.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - styleForIndex: index of line object
    /// - Returns: style object for line
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle?
    func canvasBackgroundColor(for lineChartView: BGKLineChartView) -> UIColor
    func labelMode(for lineChartView: BGKLineChartView) -> BGKLabelMode
    
    func padding(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> Double
    /// Exposes to Data Source object an internal structure for value extents to be drawn.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: BGKChartExtents object
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartExtents
    
    /// Method responsible for setting a "padding" around the values visible on the chart. Returns true by default. Returning false puts the max and min extent values as the chart's extent.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: Bool for padding
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool
}

public extension BGKLineChartDataSource {
    private func lines(in lineChartView: BGKLineChartView) -> [BGKLine] {
        var allLines: [BGKLine] = []
        for lineNumber in 0..<numberOfLinesToDraw(in: lineChartView) {
            allLines.append(points(thatForm: lineNumber, in: lineChartView))
        }
        
        return allLines
    }
    
    func string(forLabel label: BGKLineChartViewLabel, in lineChartView: BGKLineChartView) -> String? {
        switch labelMode(for: lineChartView) {
        case .hidden: return nil
        case let .range(numberOfDecimals):
            let value: Double
            
            switch label {
            case .xAxisMax: value = maxValue(for: .xAxis, in: lineChartView)
            case .xAxisMin: value = minValue(for: .xAxis, in: lineChartView)
            case .yAxisMax: value = maxValue(for: .yAxis, in: lineChartView)
            case .yAxisMin: value = minValue(for: .yAxis, in: lineChartView)
            }
            
            return String(format: "%.\(numberOfDecimals)f", value)
        case let .custom(xAxisLeft, xAxisRight, yAxisBottom, yAxisTop):
            switch label {
            case .xAxisMin: return xAxisLeft
            case .xAxisMax: return xAxisRight
            case .yAxisMin: return yAxisBottom
            case .yAxisMax: return yAxisTop
            }
        }
    }
    
    func minValue(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> Double {
        switch axis {
        case .xAxis:
            return lines(in: lineChartView).flatMap({ $0 }).map({ $0.xValue }).min() ?? 0.0
        case .yAxis:
            return lines(in: lineChartView).flatMap({ $0 }).map({ $0.yValue }).min() ?? 0.0
        }
    }
    
    func maxValue(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> Double {
        switch axis {
        case .xAxis:
            return lines(in: lineChartView).flatMap({ $0 }).map({ $0.xValue }).max() ?? 0.0
        case .yAxis:
            return lines(in: lineChartView).flatMap({ $0 }).map({ $0.yValue }).max() ?? 0.0
        }
    }
    
    func canvasBackgroundColor(for lineChartView: BGKLineChartView) -> UIColor { return .white }
    func labelMode(for lineChartView: BGKLineChartView) -> BGKLabelMode { return .hidden }
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle? { return nil }
    
    func padding(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> Double {
        return 0
    }
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartExtents {
        return BGKChartExtents(min: minValue(for: axis, in: lineChartView), max: maxValue(for: axis, in: lineChartView))
    }
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool {
        return true
    }
    func valueMin(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(for: axis, in: lineChartView)
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedMin : extents.min
    }
    func valueLength(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(for: axis, in: lineChartView)
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedLength : extents.length
    }

}
