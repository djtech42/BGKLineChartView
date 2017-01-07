//
//  BGKLineChartDataSource.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

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
    func points(thatForm lineNumber: Int, in lineChartView: BGKLineChartView) -> [BGKChartPoint]
    
    // MARK: - Methods with Default Implementations
    
    /// Method responsible for providing styling for line chart object.
    ///
    /// - Parameters:
    ///   - lineChartView: line chart object
    ///   - styleForIndex: index of line object
    /// - Returns: style object for line
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle?
    
    /// Method responsible for providing styling for the entire chart.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: style object for chart
    func style(for lineChartView: BGKLineChartView) -> BGKChartStyle?
    
    /// Exposes to Data Source object an internal structure for value extents to be drawn.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: BGKChartExtents object
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartExtents
    
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool
}
