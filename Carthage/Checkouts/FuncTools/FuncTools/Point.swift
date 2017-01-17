//
//  Function.swift
//  FuncTools
//
//  Created by Dan on 1/3/17.
//  Copyright © 2017 Dan Turner. All rights reserved.
//

public struct Point<T> {
    public let x: T
    public let y: T
}

public func inverted<T>(_ point: Point<T>) -> Point<T> {
    return Point(x: point.y, y: point.x)
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "(x: \(x), y: \(y))"
    }
}
