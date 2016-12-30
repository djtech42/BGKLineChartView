//
//  BGKLineChartProtocols.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

/// Protocol that defines the interface for an object that can provide points for BGKLineChart.
public protocol BGKLinePoint {
    var xValue: Double { get }
    var yValue: Double { get }
}

/// Protocol that defines the interface for a group of points that create a chartable object.
public protocol BGKChartable {
    var values: [BGKLinePoint] { get }
}

/// Main protocol that defines the interface for a BGKLineChartDataSource. Three methods make up the required interface for this object: numberOfLinesToDraw( : BGKLineChartView); allValues( : BGKLineChartView); and linechartView( : BGKLineChartView, pointsForIndex: Int). Additional methods provide further cusomization for the data source.
public protocol BGKLineChartDataSource: class {
    
    // MARK: - Methods that Must be Implemented by User
    
    
    /// Tells the line chart how many line objects are to be drawn.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: Integer value of number of chart objects.
    func numberOfLinesToDraw(_ lineChartView: BGKLineChartView) -> Int
    
    
    /// Exposes the data source object to custom data structure.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: Array of chartable objects to be drawn.
    func allValues(_ lineChartView: BGKLineChartView) -> [BGKChartable]
    
    
    /// Provides line points for the chart at an index.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - pointsForIndex: index of chart object
    /// - Returns: Array of line point objects
    func lineChartView(_ lineChartView: BGKLineChartView, pointsForIndex: Int) -> [BGKLinePoint]
    
    // MARK: - Methods with Default Implementations
    
    
    /// Exposes to Data Source object an internal structure for value extents to be drawn.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: BGKChartExtents object
    func valueExtents(_ lineChartView: BGKLineChartView) -> BGKChartExtents
    
    
    /// Responsible for providing the chart object with min values for a particular axis.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - forAxis: desired axis
    /// - Returns: minimum value as Double
    func valueMin(_ lineChartView: BGKLineChartView, forAxis: BGKChartAxis) -> Double
    
    
    /// Repsonsible for providing the chart object with the length each axis needs to chart.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - forAxis: desired axis
    /// - Returns: length value as Double
    func valueLength(_ lineChartView: BGKLineChartView, forAxis: BGKChartAxis) -> Double
    
    
    /// Method responsible for providing styling for line chart object.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - styleForIndex: index of line object
    /// - Returns: style object for line
    func lineChartView(_ lineChartView: BGKLineChartView, styleForIndex: Int) -> BGKLineStyle?
    
    
    /// Method responsible for providing strings for chart extents. This is used to provide values for min max on both x and y axis.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - stringForLabel: label looking for string
    /// - Returns: string value for label
    func lineChartView(_ lineChartView: BGKLineChartView, stringForLabel: BGKLineChartViewLabel) -> String?
    
    
    /// Method responsible for setting a "padding" around the values visible on the chart. Returns true by default. Returning false puts the max and min extent values as the chart's extent.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: Bool for padding
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool
}

public extension BGKLineChartDataSource {
    func valueExtents(_ lineChartView: BGKLineChartView) -> BGKChartExtents {
        return BGKChartExtents(withChartObjects: allValues(lineChartView))
    }
    func valueMin(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(lineChartView)
        switch axis {
        case .xAxis:
            return chartExtentsShouldBePadded(lineChartView) ? extents.paddedXMin : extents.xMin
        case .yAxis:
            return chartExtentsShouldBePadded(lineChartView) ? extents.paddedYMin : extents.yMin
        }
    }
    func valueLength(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(lineChartView)
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedLength(forAxis: axis) : extents.length(forAxis: axis)
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
