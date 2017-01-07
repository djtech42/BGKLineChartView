//
//  BGKLineChartViewCanvas.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/27/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

/// Class Responsible for the Drawing Plane of the Chart.
class BGKLineChartViewCanvas: UIView {
    
    var dataSource: BGKLineChartDataSource?
    var xValueExtents: BGKChartExtents?
    var yValueExtents: BGKChartExtents?
    
    var originLineWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var originLineColor: UIColor = .black {

        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let lineView = self.superview as? BGKLineChartView else { return }
        let shouldShowAxes = dataSource?.style(for: lineView)?.shouldShowAxes ?? true
        
        if shouldShowAxes {
            drawOriginLines()
        }
        drawChartLines()
    }
    
    // MARK: Drawing Helper Methods
    
    fileprivate func drawOriginLines() {
        let xOriginPath = UIBezierPath()
        let yOriginPath = UIBezierPath()
        
        xOriginPath.lineWidth = originLineWidth
        yOriginPath.lineWidth = originLineWidth
        
        originLineColor.setStroke()
        
        xOriginPath.move(to: .zero)
        xOriginPath.addLine(to: CGPoint(x: 0.0, y: bounds.height))
        yOriginPath.move(to: CGPoint(x: 0.0, y: bounds.height))
        yOriginPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        
        xOriginPath.stroke()
        yOriginPath.stroke()
    }
    
    fileprivate func drawChartLines() {
        guard let dataSource = dataSource,
            let lineView = self.superview as? BGKLineChartView else { return }
        
        let numberOfLines = dataSource.numberOfLinesToDraw(in: lineView)
        if numberOfLines == 0 {
            print(BGKConsoleOutput.noLinesWarning)
        }
        for lineNumber in 0..<numberOfLines {
            let valuePoints = dataSource.points(thatForm: lineNumber, in: lineView)
            guard !valuePoints.isEmpty else {
                print(BGKConsoleOutput.emptyLineWarning(for: lineNumber))
                continue
            }
            let canvasPoints = convertToCanvasPoints(valuePoints: valuePoints)
            drawLine(forPoints: canvasPoints, forLineNumber: lineNumber)
        }
    }
    
    // MARK: - Helper Methods
    
    fileprivate func convertToCanvasPoints(valuePoints: [BGKChartPoint]) -> [CGPoint] {
        guard let dataSource = dataSource,
            let lineView = self.superview as? BGKLineChartView, let xValueExtents = xValueExtents, let yValueExtents = yValueExtents else { return [] }
        
        let xAxisScale = dataSource.scaleValue(in: lineView, for: .xAxis, with: xValueExtents)
        let yAxisScale = dataSource.scaleValue(in: lineView, for: .yAxis, with: yValueExtents)
        let xMin = dataSource.minValue(in: lineView, with: xValueExtents)
        let yMin = dataSource.minValue(in: lineView, with: yValueExtents)
        
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
    
    fileprivate func drawLine(forPoints points: [CGPoint], forLineNumber lineNumber: Int) {
        guard let dataSource = dataSource,
            let lineView = self.superview as? BGKLineChartView else { return }
        let lineStyle = dataSource.style(for: lineNumber, in: lineView)
        let path = UIBezierPath()
        
        var pointsToDraw = points
        
        if let existingLineStyle = lineStyle {
            if existingLineStyle.thickness == 0 {
                print(BGKConsoleOutput.noLineThicknessWarning(for: lineNumber))
            }
            path.lineWidth = existingLineStyle.thickness
            existingLineStyle.color.setStroke()
        }
        else {
            path.lineWidth = 1.0
            UIColor.black.setStroke()
        }
        
        let lineOrigin = pointsToDraw.removeFirst()
        path.move(to: lineOrigin)
        
        for point in pointsToDraw {
            path.addLine(to: point)
        }
        
        path.stroke()
    }

}
