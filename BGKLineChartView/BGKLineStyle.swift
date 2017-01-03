//
//  BGKLineStyle.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

/// Struct used to provide basic line styling to line chart objects.
public struct BGKLineStyle {
    let thickness: CGFloat
    let color: UIColor
    
    public init(withThickness thickness: CGFloat?, andColor color: UIColor?) {
        if let changedThickness = thickness {
            self.thickness = changedThickness
        }
        else {
            self.thickness = 1.0
        }
        
        if let changedColor = color {
            self.color = changedColor
        }
        else {
            self.color = .black
        }
    }
}
