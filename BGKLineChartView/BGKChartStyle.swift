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
    let canvasBackgroundColor: UIColor
    
    public init(withCanvasBackgroundColor canvasBackgroundColor: UIColor) {
        self.canvasBackgroundColor = canvasBackgroundColor
    }
}
