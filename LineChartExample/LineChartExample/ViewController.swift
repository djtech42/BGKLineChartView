//
//  ViewController.swift
//  LineChartExample
//
//  Created by Brenden Konnagan on 12/30/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit
import BGKLineChartView
import FuncTools

class ViewController: UIViewController {
    // ------------------------------- IBOutlets -----------------------------------
    @IBOutlet weak var lineChart: BGKLineChartView!
    
    // ------------------------------- Model Data -----------------------------------
    lazy var modelData: [BGKChartObject] = {
        var mergedValues: [BGKChartObject] = []
        
        let sampleGroups = (
            first: [1, 3, 5, 7, 9],
            second: [2, 4, 6, 8, 10]
        )
        
        var lines: (BGKChartObject, BGKChartObject, BGKChartObject) = ([], [], [])
        
        for (index, sample) in sampleGroups.first.enumerated() {
            let point = BGKBasicPoint(
                xValue: Double(sample),
                yValue: Double(sampleGroups.second[index])
            )
            let otherPoint = BGKBasicPoint(
                xValue: Double(sampleGroups.second[index] * 4),
                yValue: Double(sample * 2)
            )
            
            lines.0.append(point)
            lines.1.append(otherPoint)
        }
        
        lines.2 = ExpandedFunction({ sin($0) * 5 }, overRange: 0..<30).points
        
        mergedValues.append(lines.0)
        mergedValues.append(lines.1)
        mergedValues.append(lines.2)
        
        return mergedValues
    }()
    
    
    // ------------------------------- Connect Data Source -----------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.dataSource = self
    }
}


extension ViewController: BGKLineChartDataSource {
    // ------------------------------- Data -----------------------------------
    func chartItems(in lineChartView: BGKLineChartView) -> [BGKChartObject] {
        return modelData
    }
    
    
    // ------------------------------- Style -----------------------------------
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle? {
        return BGKLineStyle(withThickness: 2.0, andColor: .black)
    }
    
    func style(for lineChartView: BGKLineChartView) -> BGKChartStyle? {
        return BGKChartStyle(withBackgroundColor: .lightGray, andShowingAxes: true, withLabelMode: .minMax(withLimitedNumberOfDecimalDigits: 2))
    }
    
    func chartExtentsShouldBePadded(_ lineChartView: BGKLineChartView) -> Bool {
        return false
    }
}
