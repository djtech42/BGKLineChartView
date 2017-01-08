//
//  BGKLineChartDataSource + Default.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

/// Below are private protocol default implementations.

// MARK: - Responsible for Providing the Point Data Sets for A Giving Chart Object
extension BGKLineChartDataSource {
    func chartPoints(thatForm lineNumber: Int, in lineChartView: BGKLineChartView) -> [BGKChartPoint] {
        let values = chartItems(in: lineChartView)
        return values.element(at: lineNumber) ?? []
    }
}


// MARK: - Responsible for Determining Value Extents for the Canvas
extension BGKLineChartDataSource {
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartExtents {
        let values = chartItems(in: lineChartView)
        switch axis {
        case .xAxis:
            return BGKChartExtents(withAllAxisValues: values.flatMap({ $0 }).map({ $0.xValue }))
        case .yAxis:
            return BGKChartExtents(withAllAxisValues: values.flatMap({ $0 }).map({ $0.yValue }))
        }
    }
}

// MARK: - Responsible for Providing String Values for Labels Based on Label Mode
extension BGKLineChartDataSource {
    func string(forLabel label: BGKLineChartViewLabel, with extents: (xExtents: BGKChartExtents, yExtents: BGKChartExtents), in lineChartView: BGKLineChartView) -> String? {
        guard let labelMode = style(for: lineChartView)?.labelMode else { return nil }
        switch labelMode {
        case .hidden: return nil
        case let .minMax(numberOfDecimals):
            let value: Double
            switch label {
            case .xAxisMax: value = chartExtentsShouldBePadded(lineChartView) ? extents.xExtents.paddedMax : extents.xExtents.max
            case .xAxisMin: value = chartExtentsShouldBePadded(lineChartView) ? extents.xExtents.paddedMin : extents.xExtents.min
            case .yAxisMax: value = chartExtentsShouldBePadded(lineChartView) ? extents.yExtents.paddedMax : extents.yExtents.max
            case .yAxisMin: value = chartExtentsShouldBePadded(lineChartView) ? extents.yExtents.paddedMin : extents.yExtents.min
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
}

// MARK: - Responsible for Providing Min Values for Chart Axis
extension BGKLineChartDataSource {
    func minValue(in lineChartView: BGKLineChartView, with extents: BGKChartExtents) -> Double {
        return chartExtentsShouldBePadded(lineChartView) ? extents.paddedMin : extents.min
    }
}

// MARK: - Responsible for Calculating Scale for Canvas View
extension BGKLineChartDataSource {
    func scaleValue(in lineChartView: BGKLineChartView, for axis: BGKChartAxis, with extents: BGKChartExtents) -> Double {
        var bounds: CGFloat = 0.0
        switch axis {
        case .xAxis:
            bounds = lineChartView.canvas.bounds.width
        case .yAxis:
            bounds = lineChartView.canvas.bounds.height
        }
        return chartExtentsShouldBePadded(lineChartView) ? Double(bounds) / extents.paddedLength : Double(bounds) / extents.length
    }
}
