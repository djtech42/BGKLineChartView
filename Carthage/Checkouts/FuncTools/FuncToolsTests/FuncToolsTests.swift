//
//  FuncToolsTests.swift
//  FuncToolsTests
//
//  Created by Dan on 1/3/17.
//  Copyright © 2017 Dan Turner. All rights reserved.
//

import XCTest
@testable import FuncTools

class FuncToolsTests: XCTestCase {
    func testBasicFunction1() {
        var expansion = ExpandedFunction(sqrt, overRange: 0..<100, atResolution: 50)
        print(expansion.points)
        expansion.range = 0..<10
        print(expansion.points)
    }
}
