//
//  BGKLineChartView.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/26/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

/// Class responsible for the Line Chart and basic labels. Must implement and set the dataSource property.
public class BGKLineChartView: UIView {
    
    let standardSpacing: CGFloat = 8.0
    let yMaxLabel = UILabel(frame: .zero)
    let yMinLabel = UILabel(frame: .zero)
    let xMinLabel = UILabel(frame: .zero)
    let xMaxLabel = UILabel(frame: .zero)
    let canvas = BGKLineChartViewCanvas(frame: .zero)
    var xValueExtents: BGKChartExtents?
    var yValueExtents: BGKChartExtents?
    
    /// Set to a class that conforms to BGKLineChartDataSource protocol.
    public var dataSource: BGKLineChartDataSource? {
        didSet {
            refreshView()
        }
    }
    
    fileprivate var labels: [UILabel] {
        return [yMaxLabel, yMinLabel, xMinLabel, xMaxLabel]
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        refreshView()
    }
    
    fileprivate func refreshView() {
        guard let dataSource = dataSource else { return }
        if subviews.isEmpty { setupLayoutNeeds() }
        canvas.dataSource = dataSource
        xValueExtents = dataSource.valueExtents(for: .xAxis, in: self)
        yValueExtents = dataSource.valueExtents(for: .yAxis, in: self)
        canvas.xValueExtents = xValueExtents
        canvas.yValueExtents = yValueExtents
        setupCanvas()
        setupLabels()
    }
    
    // MARK: - AutoLayout
    
    fileprivate func setupLayoutNeeds() {
        addViews()
        setupCanvas()
        layoutCanvas()
        layoutYMaxLabel()
        layoutYMinLabel()
        layoutXMinLabel()
        layoutXMaxLabel()
    }
    
    fileprivate func addViews() {
        let views: [UIView] = [yMaxLabel, yMinLabel, xMinLabel, xMaxLabel, canvas]
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    fileprivate func setupCanvas() {
        canvas.backgroundColor = dataSource?.style(for: self)?.backgroundColor ?? .white
    }
    
    fileprivate func layoutCanvas() {
        canvas.topAnchor.constraint(equalTo: topAnchor, constant: standardSpacing).isActive = true
        trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: standardSpacing).isActive = true
        canvas.leadingAnchor.constraint(equalTo: yMaxLabel.trailingAnchor, constant: standardSpacing).isActive = true
        canvas.leadingAnchor.constraint(equalTo: yMinLabel.trailingAnchor, constant: standardSpacing).isActive = true
    }
    
    fileprivate func layoutYMaxLabel() {
        yMaxLabel.topAnchor.constraint(equalTo: canvas.topAnchor).isActive = true
        yMaxLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardSpacing).isActive = true
    }
    
    fileprivate func layoutYMinLabel() {
        yMinLabel.bottomAnchor.constraint(equalTo: canvas.bottomAnchor).isActive = true
        yMinLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardSpacing).isActive = true
        yMinLabel.widthAnchor.constraint(equalTo: yMaxLabel.widthAnchor).isActive = true
    }
    
    fileprivate func layoutXMinLabel() {
        bottomAnchor.constraint(equalTo: xMinLabel.bottomAnchor, constant: standardSpacing).isActive = true
        xMinLabel.centerXAnchor.constraint(equalTo: canvas.leadingAnchor).isActive = true
        xMinLabel.topAnchor.constraint(equalTo: canvas.bottomAnchor, constant: standardSpacing).isActive = true
        xMinLabel.widthAnchor.constraint(equalTo: yMaxLabel.widthAnchor).isActive = true
    }
    
    fileprivate func layoutXMaxLabel() {
        bottomAnchor.constraint(equalTo: xMaxLabel.bottomAnchor, constant: standardSpacing).isActive = true
        xMaxLabel.topAnchor.constraint(equalTo: canvas.bottomAnchor, constant: standardSpacing).isActive = true
        xMaxLabel.trailingAnchor.constraint(equalTo: canvas.trailingAnchor).isActive = true
        xMaxLabel.widthAnchor.constraint(equalTo: yMaxLabel.widthAnchor).isActive = true
    }
    
    // MARK: - Configure Views
    
    fileprivate func setupLabels() {
        guard let dataSource = dataSource, let xValueExtents = xValueExtents, let yValueExtents = yValueExtents else { return }
        for label in labels {
            label.numberOfLines = 1
            label.lineBreakMode = .byTruncatingTail
        }
        /// Set text for labels
        yMaxLabel.text = dataSource.string(forLabel: .yAxisMax, with: (xValueExtents, yValueExtents), in: self)
        yMinLabel.text = dataSource.string(forLabel: .yAxisMin, with: (xValueExtents, yValueExtents), in: self)
        xMinLabel.text = dataSource.string(forLabel: .xAxisMin, with: (xValueExtents, yValueExtents), in: self)
        xMaxLabel.text = dataSource.string(forLabel: .xAxisMax, with: (xValueExtents, yValueExtents), in: self)
        /// Set Label Alignment
        yMaxLabel.textAlignment = .right
        yMinLabel.textAlignment = .right
        xMinLabel.textAlignment = .center
        xMaxLabel.textAlignment = .right
    }

}
