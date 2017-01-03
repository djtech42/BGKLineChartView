//
//  LabelMode.swift
//  BGKLineChartView
//
//  Created by Dan on 12/29/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation


/// Label Mode specifies behavior for the four labels on the line chart.
///
/// - hidden: hide all labels
/// - range: show minimum and maximum rounded to number of decimal digits
/// - custom: specify custom text for each label
public enum BGKLabelMode {
    case hidden
    case range(numberOfDecimalDigits: Int)
    case custom(xAxisLeft: String, xAxisRight: String, yAxisBottom: String, yAxisTop: String)
}
