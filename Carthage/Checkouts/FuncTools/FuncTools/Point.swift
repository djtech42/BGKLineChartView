//
//  Function.swift
//  FuncTools
//
//  Created by Dan on 1/3/17.
//  Copyright © 2017 Dan Turner. All rights reserved.
//

public struct Point {
    public let x: Double
    public let y: Double
}

public func inverted(_ point: Point) -> Point {
    return Point(x: point.y, y: point.x)
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "(x: \(x), y: \(y))"
    }
}
