//
//  LabelMode.swift
//  BGKLineChartView
//
//  Created by Dan on 12/29/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public enum BSGLabelMode {
    case hidden
    case range(numberOfDecimals: Int)
    case custom(xAxisLeft: String, xAxisRight: String, yAxisBottom: String, yAxisTop: String)
}
