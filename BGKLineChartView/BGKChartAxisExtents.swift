//
//  BGKChartAxisExtents.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

public struct BGKChartExtents {
    
    fileprivate let objects: [BGKChartable]
    
    fileprivate var xValues: [Double] {
        return objects.flatMap({ $0.values }).map({ $0.xValue })
    }
    
    fileprivate var yValues: [Double] {
        return objects.flatMap({ $0.values }).map({ $0.yValue })
    }
    
    // MARK: - Public API
    
    public var xMin: Double {
        return xValues.min() ?? 0.0
    }
    
    public var paddedXMin: Double {
        return xMin * 0.9
    }
    
    public var xMax: Double {
        return xValues.max() ?? 0.0
    }
    
    public var paddedXMax: Double {
        return xMax * 1.1
    }
    
    public var yMin: Double {
        return yValues.min() ?? 0.0
    }
    
    public var paddedYMin: Double {
        return yMin * 0.9
    }
    
    public var paddedYMax: Double {
        return yMax * 1.1
    }
    
    public var yMax: Double {
         return yValues.max() ?? 0.0
    }
    
    public init(withChartObjects objects: [BGKChartable]) {
        self.objects = objects
    }
    
    public func length(forAxis axis: BGKChartAxis) -> Double {
        switch axis {
        case .xAxis:
            return xMax - xMin
        case .yAxis:
            return yMax - yMin
        }
    }
    
    public func paddedLength(forAxis axis: BGKChartAxis) -> Double {
        switch axis {
        case .xAxis:
            return paddedXMax - paddedXMin
        case .yAxis:
            return paddedYMax - paddedYMin
        }
    }
}
