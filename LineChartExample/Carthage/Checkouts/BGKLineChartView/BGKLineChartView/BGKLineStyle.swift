//
//  BGKLineStyle.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

/// Class used to provide basic styling to line chart objects.
public class BGKLineStyle {
    var thickness: CGFloat
    var color: UIColor
    
    init(withThickness thickness: CGFloat, andColor color: UIColor) {
        self.thickness = thickness
        self.color = color
    }
}
