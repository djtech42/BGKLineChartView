//
//  Transform Functions.swift
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
    
    public var line: Line = Line(with: [])
    public var points: [Point] = []
    
    
    public init(_ function: @escaping (Double) -> Double, usingValueSystem valueSystem: FunctionValueSystem = .y, overRange range: Range<Double>, atResolutionLevel resolutionLevel: ResolutionLevel = .medium) {
        self.function = function
        self.valueSystem = valueSystem
        
        self.range = range
        self.resolutionLevel = resolutionLevel
        
        updatePoints()
    }
    
    
    private mutating func updatePoints() {
        let xValues = stride(from: range.lowerBound, to: range.upperBound, by: calculatedStride)
        switch valueSystem {
        case .y:
            points = xValues.map({ Point(x: $0, y: function($0)) })
            line = Line(with: points)
        case .x:
            points = xValues.map({ Point(x: function($0), y: $0) })
            line = Line(with: points)
        }
    }
    
    private var calculatedStride: Double.Stride {
        return range.lowerBound.distance(to: range.lowerBound + range.upperBound / resolutionLevel.rawValue)
    }
}
