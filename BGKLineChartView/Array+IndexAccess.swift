//
//  Array+IndexAccess.swift
//  BGKLineChartView
//
//  Created by Dan on 12/29/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import Foundation

extension Array {
    public func element(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
}
