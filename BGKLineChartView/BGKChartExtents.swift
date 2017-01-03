//
//  BGKChartAxisExtents.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public struct BGKChartExtents {
    public let min: Double
    public let max: Double
    
    public init(min: Double, max: Double) {
        self.min = min
        self.max = max
    }
    
    public var length: Double {
        return max - min
    }
    
    public var paddedMin: Double {
        return min * 0.2
    }
    
    public var paddedMax: Double {
        return max * 1.2
    }
    
    public var paddedLength: Double {
        return paddedMax - paddedMin
    }
}
