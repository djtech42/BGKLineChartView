//
//  BGKLineChartDataSource + Default Implementations.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

/// Below are default protocol implementations that can be overridden by the user.

// MARK: - Chart Style
public extension BGKLineChartDataSource {
    func style(for lineChartView: BGKLineChartView) -> BGKChartStyle? { return nil }
}

// MARK: - Line Style
public extension BGKLineChartDataSource {
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle? { return nil }
}

// MARK: - Chart Value Padding
public extension BGKLineChartDataSource {
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool { return true }
}
