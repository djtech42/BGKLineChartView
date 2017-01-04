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
    
    public init(withBackgroundColor backgroundColor: UIColor?, andShowingAxes shouldShowAxes: Bool?) {
        self.backgroundColor = backgroundColor ?? .white
        self.shouldShowAxes = shouldShowAxes ?? true
    }
}
