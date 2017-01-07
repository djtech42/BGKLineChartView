//
//  BGKChartable.swift
//  BGKLineChartView
//
//  Created by Brenden Konnagan on 1/7/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import Foundation

public typealias BGKChartObject = [BGKChartPoint]

/// Protocol that defines the interface for a group of points that create a chartable object.
public protocol BGKChartable {
    var values: [BGKChartPoint] { get }
}
