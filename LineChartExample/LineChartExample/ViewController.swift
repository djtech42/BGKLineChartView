//
//  ViewController.swift
//  LineChartExample
//
//  Created by Brenden Konnagan on 12/30/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit
import BGKLineChartView

class ViewController: UIViewController {

    @IBOutlet weak var lineChart: BGKLineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Helper method to setup data
    func setupData() {
        
        struct SampleData: BGKLinePoint {
            var xValue: Double
            var yValue: Double
        }
        
        struct SampleLine: BGKChartable {
            var values: [BGKLinePoint]
        }
        
        let samples = [1, 3, 5, 7, 9]
        let samplesTwo = [2, 4, 6, 8, 10]
        var line1: [BGKLinePoint] = []
        var line2: [BGKLinePoint] = []
        for (index, sample) in samples.enumerated() {
            let point = SampleData(xValue: Double(sample), yValue: Double(samplesTwo[index]))
            let otherPoint = SampleData(xValue: Double(samplesTwo[index] * 4), yValue: Double(sample * 2))
            line1.append(point)
            line2.append(otherPoint)
        }
        
        values.append(SampleLine(values: line1))
        values.append(SampleLine(values: line2))
        
        lineChart.dataSource = self
    }
    
    var values: [BGKChartable] = []
}

extension ViewController: BGKLineChartDataSource {
    // DataSource Conformance
    func numberOfLinesToDraw(in lineChartView: BGKLineChartView) -> Int {
        return values.count
    }
    
    func points(thatForm lineNumber: Int, in lineChartView: BGKLineChartView) -> [BGKLinePoint] {
        return values[lineNumber].values
<<<<<<< HEAD
=======
    }
    func labelMode(for lineChartView: BGKLineChartView) -> BGKLabelMode {
        return .range(numberOfDecimals: 1)
>>>>>>> dev
    }
}

extension ViewController {
    func style(for lineNumber: Int, in lineChartView: BGKLineChartView) -> BGKLineStyle? {
        return BGKLineStyle(withThickness: 2.0, andColor: .black)
    }
    
    func labelMode(for lineChartView: BGKLineChartView) -> BGKLabelMode {
        return .range(numberOfDecimalDigits: 0)
    }
}
