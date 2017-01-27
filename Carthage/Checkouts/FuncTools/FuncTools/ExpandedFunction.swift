//
//  ExpandedFunctions.swift
//  FuncTools
//
//  Created by Dan on 1/15/17.
//  Copyright © 2017 Dan Turner. All rights reserved.
//

public enum FunctionValueSystem {
    case y
    case x
}

public struct ExpandedFunction {
    public enum ResolutionLevel: RawRepresentable {
        case veryLow
        case low
        case medium
        case high
        case veryHigh
        case custom(Double)
        
        public var rawValue: Double {
            switch self {
            case .veryLow: return 20
            case .low: return 40
            case .medium: return 80
            case .high: return 160
            case .veryHigh: return 320
            case let .custom(value): return value
            }
        }
        
        public init?(rawValue: Double) {
            switch rawValue {
            case 20: self = .veryLow
            case 40: self = .low
            case 80: self = .medium
            case 160: self = .high
            case 320: self = .veryHigh
            default: self = .custom(rawValue)
            }
        }
    }
    
    public let function: (Double) -> Double
    public var valueSystem: FunctionValueSystem {
        didSet {
            updatePoints()
        }
    }
    
    public var range: Range<Double> {
        didSet {
            updatePoints()
        }
    }
    public var resolutionLevel: ResolutionLevel {
        didSet {
            updatePoints()
        }
    }
    
    public var points: [Point] = []
    public var xValues: [Double] = []
    public var yValues: [Double] = []
    
    public var max: Double? {
        return yValues.max()
    }
    public var min: Double? {
        return yValues.min()
    }
    
    public var linearRegressionLine: ExpandedFunction {
        let meanX = points.reduce(0) { $0 + $1.x } / Double(points.count)
        let meanY = points.reduce(0) { $0 + $1.y } / Double(points.count)
        
        let a = points.reduce(0) { $0 + ($1.x - meanX) * ($1.y - meanY) }
        let b = points.reduce(0) { $0 + pow($1.x - meanX, 2) }
        
        let m = a / b
        let c = meanY - m * meanX
        
        return ExpandedFunction({ m * $0 + c }, usingValueSystem: valueSystem, overRange: range, atResolutionLevel: resolutionLevel)
    }
    
    
    public init(_ function: @escaping (Double) -> Double, usingValueSystem valueSystem: FunctionValueSystem = .y, overRange range: Range<Double>, atResolutionLevel resolutionLevel: ResolutionLevel = .medium) {
        self.function = function
        self.valueSystem = valueSystem
        
        self.range = range
        self.resolutionLevel = resolutionLevel
        
        updatePoints()
    }
    
    
    private mutating func updatePoints() {
        switch valueSystem {
        case .y:
            xValues = stride(from: range.lowerBound, to: range.upperBound, by: calculatedStride).map({ $0 })
            yValues = xValues.map({ function($0) })
        case .x:
            xValues = xValues.map({ function($0) })
            yValues = stride(from: range.lowerBound, to: range.upperBound, by: calculatedStride).map({ $0 })
        }
        
        points = xValues.enumerated().map({ Point(x: xValues[$0.offset], y: yValues[$0.offset]) })
    }
    
    private var calculatedStride: Double.Stride {
        return range.lowerBound.distance(to: range.lowerBound + range.upperBound / resolutionLevel.rawValue)
    }
}
