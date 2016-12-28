//
//  BGKChartAxisExtents.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public struct BGKChartAxisExtents {
    public let min: Double
    public let max: Double
    
    public var length: Double {
        return max - min
    }
    
    public var paddedMin: Double {
        return min * 0.9
    }
    
    public var paddedMax: Double {
        return max * 1.1
    }
    
    public var paddedLength: Double {
        return paddedMax - paddedMin
    }
}
