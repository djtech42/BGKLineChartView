//
//  Line.swift
//  FuncTools
//
//  Created by Dan on 1/15/17.
//  Copyright © 2017 Dan Turner. All rights reserved.
//

public struct Line {
    public let points: [Point]
    public var xValues: [Double] {
        return points.map({ $0.x })
    }
    public var yValues: [Double] {
        return points.map({ $0.y })
    }
    
    public init(with points: [Point]) {
        self.points = points
    }
    
    public var max: Double? {
        return yValues.max()
    }
    public var min: Double? {
        return yValues.min()
    }
}

public func inverted(_ line: Line) -> Line {
    return Line(with: line.points.map(inverted))
}

extension Line: CustomStringConvertible {
    public var description: String {
        return points.description
    }
}
