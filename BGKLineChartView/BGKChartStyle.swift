//
//  BGKChartStyle.swift
//  BGKLineChartView
//
//  Created by Dan Turner on 1/3/17.
//  Copyright © 2017 Brenden Konnagan. All rights reserved.
//

import UIKit

/// Struct used to provide basic styling to a line chart.
public struct BGKChartStyle {
    let backgroundColor: UIColor
    let shouldShowAxes: Bool
    let labelMode: BGKLabelMode
    
    public init(withBackgroundColor backgroundColor: UIColor?, andShowingAxes shouldShowAxes: Bool?, withLabelMode labelMode: BGKLabelMode?) {
        self.backgroundColor = backgroundColor ?? .white
        self.shouldShowAxes = shouldShowAxes ?? true
        self.labelMode = labelMode ?? .hidden
    }
}
