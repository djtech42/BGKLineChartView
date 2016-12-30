//
//  ConsoleOutput.swift
//  BGKLineChartView
//
//  Created by Dan on 12/29/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

enum BSGConsoleOutput {
    static func standardWarning(with text: String) -> String {
        return "! BGKLineChartView: \(text)"
    }
    static func emptyLineWarning(for lineNumber: Int) -> String {
        return standardWarning(with: "Line number \(lineNumber) does not contain any data.")
    }
    static var noLinesWarning: String {
        return standardWarning(with: "Chart is set to not draw any lines.")
    }
    static func noLineThicknessWarning(for lineNumber: Int) -> String {
        return standardWarning(with: "Line number \(lineNumber) has its thickness set to 0.")
    }
}
