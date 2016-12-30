//
//  BGKLineChartProtocols.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public typealias BGKLine = [BGKPlottablePoint]

public protocol BGKPlottablePoint {
    var xValue: Double { get }
    var yValue: Double { get }
}

public protocol BGKLineChartDataSource: class {
    func numberOfLinesToDraw(in lineChartView: BGKLineChartView) -> Int
    func points(thatForm lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLine
    
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle?
    func labelMode(for lineChartView: BGKLineChartView) -> BSGLabelMode
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartAxisExtents
}

extension BGKLineChartDataSource {
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
    
    func labelMode(for lineChartView: BGKLineChartView) -> BSGLabelMode { return .hidden }
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle? { return nil }
    
    func valueExtents(for axis: BGKChartAxis, in lineChartView: BGKLineChartView) -> BGKChartAxisExtents {
        return BGKChartAxisExtents(min: minValue(for: axis, in: lineChartView), max: maxValue(for: axis, in: lineChartView))
    }
}
