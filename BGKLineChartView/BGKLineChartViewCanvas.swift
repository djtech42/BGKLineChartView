//
//  BGKLineChartViewCanvas.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

class BGKLineChartViewCanvas: UIView {
    
    public var dataSource: BGKLineChartDataSource?
    
    public var originLineWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var originLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawOriginLines()
        drawChartLines()
    }
    
    fileprivate func drawOriginLines() {
        let xOriginPath = UIBezierPath()
        let yOriginPath = UIBezierPath()
        
        xOriginPath.lineWidth = originLineWidth
        yOriginPath.lineWidth = originLineWidth
        
        originLineColor.setStroke()
        
        xOriginPath.move(to: CGPoint.zero)
        xOriginPath.addLine(to: CGPoint(x: 0.0, y: bounds.height))
        yOriginPath.move(to: CGPoint(x: 0.0, y: bounds.height))
        yOriginPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        
        xOriginPath.stroke()
        yOriginPath.stroke()
    }
    
    fileprivate func drawChartLines() {
        guard let dataSource = dataSource,
            let lineView = self.superview as? BGKLineChartView else { return }
        for lineNumber in 0..<dataSource.numberOfLinesToDraw(lineView) {
            let valuePoints = dataSource.lineChartView(lineView, pointsForIndex: lineNumber)
            let canvasPoints = convertToCanvasPoints(valuePoints: valuePoints)
            drawLine(forPoints: canvasPoints, forLineNumber: lineNumber)
        }
    }
    
    // MARK: - Helper Methods
    
    fileprivate func convertToCanvasPoints(valuePoints: [BGKLinePoint]) -> [CGPoint] {
        guard let dataSource = dataSource,
            let lineView = self.superview as? BGKLineChartView else { return [] }
        let xAxisScale = bounds.width / CGFloat(dataSource.valueLength(lineView, forAxis: .xAxis))
        let yAxisScale = bounds.height / CGFloat(dataSource.valueLength(lineView, forAxis: .yAxis))
        let xMin = dataSource.valueMin(lineView, forAxis: .xAxis)
        let yMin = dataSource.valueMin(lineView, forAxis: .yAxis)
        var points: [CGPoint] = []
        for value in valuePoints {
            let xValue = (value.xValue - xMin) * Double(xAxisScale)
            let yValue = (value.yValue - yMin) * Double(yAxisScale)
            let yValueForBottomOrigin = Double(bounds.height) - yValue
            let newPoint = CGPoint(x: xValue, y: yValueForBottomOrigin)
            points.append(newPoint)
        }
        return points
    }
    
    fileprivate func drawLine(forPoints points: [CGPoint], forLineNumber index: Int) {
        guard let dataSource = dataSource,
            let lineView = self.superview as? BGKLineChartView else { return }
        let lineStyle = dataSource.lineChartView(lineView, styleForIndex: index)
        let path = UIBezierPath()
        
        path.lineWidth = lineStyle?.lineWidth ?? 1.0
        (lineStyle != nil) ? lineStyle?.lineColor.setStroke() : UIColor.blue.setStroke()
        
        var pointsToDraw = points
        let lineOrigin = pointsToDraw.removeFirst()
        path.move(to: lineOrigin)
        
        for point in pointsToDraw {
            path.addLine(to: point)
        }
        
        path.stroke()
    }

}
