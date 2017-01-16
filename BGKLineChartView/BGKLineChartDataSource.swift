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
    
    /// Provides the interface in which to provide a data structure to the chart.
    ///
    /// - Parameter lineChartView: line chart view object
    /// - Returns: a collection of chart objects.
    func chartItems(in lineChartView: BGKLineChartView) -> [BGKChartObject]
    
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
    
    /// Tells the chart that the values drawn in the canvas will have a padding on the extents. This ensures that the values are drawn inside the edge of the canvas. This returns true by default.
    ///
    /// - Parameter lineChartView: line chart object
    /// - Returns: True for padded, false for no padding.
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool
}
