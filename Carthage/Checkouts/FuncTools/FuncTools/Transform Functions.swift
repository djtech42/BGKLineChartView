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

public struct ExpandedFunction<T: BinaryFloatingPoint> {
    public let function: (T) -> T
    public var valueSystem: FunctionValueSystem {
        didSet {
            updatePoints()
        }
    }
    
    public var range: Range<T> {
        didSet {
            updatePoints()
        }
    }
    public var resolution: T {
        didSet {
            updatePoints()
        }
    }
    
    public var points: Line<T> = Line(with: [])
    
    
    public init(_ function: @escaping (T) -> T, usingValueSystem valueSystem: FunctionValueSystem = .y, overRange range: Range<T>, atResolution resolution: T) {
        self.function = function
        self.valueSystem = valueSystem
        
        self.range = range
        self.resolution = resolution
        
        updatePoints()
    }
    
    
    private mutating func updatePoints() {
        let xValues = stride(from: range.lowerBound, to: range.upperBound, by: calculatedStride)
        switch valueSystem {
        case .y: points = Line(with: xValues.map({ Point(x: $0, y: function($0)) }))
        case .x: points = Line(with: xValues.map({ Point(x: function($0), y: $0) }))
        }
    }
    
    private var calculatedStride: T.Stride {
        return range.lowerBound.distance(to: range.lowerBound + range.upperBound / resolution)
    }
}
