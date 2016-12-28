//
//  BGKLineStyle.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

public protocol BGKLineStyle: class {
    var lineWidth: CGFloat { get }
    var lineColor: UIColor { get }
}

extension BGKLineStyle {
    var lineWidth: CGFloat {
        return 1.0
    }
    var lineColor: UIColor {
        return UIColor.blue
    }
}
