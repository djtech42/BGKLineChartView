//
//  FuncTools Conformances.swift
//  BGKLineChartView
//
//  Created by Dan on 1/25/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import FuncTools

extension Point: BGKChartPoint {
    public var xValue: Double {
        return x
    }
    public var yValue: Double {
        return y
    }
}

extension Line: BGKChartable {
    public var values: [BGKChartPoint] {
        return points
    }
}
