//
//  Line.swift
//  FuncTools
//
//  Created by Dan on 1/15/17.
//  Copyright © 2017 Dan Turner. All rights reserved.
//

public struct Line<T: BinaryFloatingPoint> {
    public let points: [Point<T>]
    public var xValues: [T] {
        return points.map({ $0.x })
    }
    public var yValues: [T] {
        return points.map({ $0.y })
    }
    
    public init(with points: [Point<T>]) {
        self.points = points
    }
    
    public var max: T? {
        return yValues.max()
    }
    public var min: T? {
        return yValues.min()
    }
}

public func inverted<T>(_ line: Line<T>) -> Line<T> {
    return Line(with: line.points.map(inverted))
}

extension Line: CustomStringConvertible {
    public var description: String {
        return points.description
    }
}
