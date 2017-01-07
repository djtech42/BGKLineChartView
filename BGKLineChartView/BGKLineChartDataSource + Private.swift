//
//  BGKLineChartDataSource + Default.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

/// Below are private protocol default implementations.


// MARK: - Responsible for Determining Value Extents for the Canvas
extension BGKLineChartDataSource {
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartExtents {
        switch axis {
        case .xAxis:
            return BGKChartExtents(withAllAxisValues: chartItems.flatMap({ $0 }).map({ $0.xValue }))
        case .yAxis:
            return BGKChartExtents(withAllAxisValues: chartItems.flatMap({ $0 }).map({ $0.yValue }))
        }
    }
}

























extension BGKLineChartDataSource {
    private func lines(in lineChartView: BGKLineChartView) -> [BGKChartObject] {
        var allLines: [BGKChartObject] = []
        for lineNumber in 0..<numberOfLinesToDraw(in: lineChartView) {
            allLines.append(points(thatForm: lineNumber, in: lineChartView))
        }
        
        return allLines
    }
    
    func string(forLabel label: BGKLineChartViewLabel, in lineChartView: BGKLineChartView) -> String? {
        
        guard let labelMode = style(for: lineChartView)?.labelMode else { return nil }
        switch labelMode {
        case .hidden: return nil
        case let .minMax(numberOfDecimals):
            
            let value: Double
            
            switch label {
            case .xAxisMax: value = valueMax(lineChartView, forAxis: .xAxis)
            case .xAxisMin: value = valueMin(lineChartView, forAxis: .xAxis)
            case .yAxisMax: value = valueMax(lineChartView, forAxis: .yAxis)
            case .yAxisMin: value = valueMin(lineChartView, forAxis: .yAxis)
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
    
    
    
    
    
    func valueMin(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(for: axis, in: lineChartView)
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedMin : extents.min
    }
    func valueMax(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(for: axis, in: lineChartView)
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedMax : extents.max
    }
    func valueLength(_ lineChartView: BGKLineChartView, forAxis axis: BGKChartAxis) -> Double {
        let extents = valueExtents(for: axis, in: lineChartView)
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedLength : extents.length
    }
    
    
    
}
