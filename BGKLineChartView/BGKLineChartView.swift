//
//  BGKLineChartView.swift
//  Line Chart
//
//  Created by Brenden Konnagan on 12/26/16.
//  Copyright © 2016 Brenden Konnagan. All rights reserved.
//

import UIKit

public class BGKLineChartView: UIView {
    
    let standardSpacing: CGFloat = 8.0
    let yMaxLabel = UILabel(frame: CGRect.zero)
    let yMinLabel = UILabel(frame: CGRect.zero)
    let xMinLabel = UILabel(frame: CGRect.zero)
    let xMaxLabel = UILabel(frame: CGRect.zero)
    let canvas = BGKLineChartViewCanvas(frame: CGRect.zero)
    
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
        if subviews.count < 1 {
            setupLayoutNeeds()
        }
        canvas.dataSource = dataSource
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
        canvas.backgroundColor = UIColor.white
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
        guard let dataSource = dataSource else { return }
        for label in labels {
            label.numberOfLines = 1
            label.lineBreakMode = .byTruncatingTail
        }
        yMaxLabel.text = dataSource.lineChartView(self, stringForLabel: .yAxisMax)
        yMaxLabel.textAlignment = .right
        yMinLabel.text = dataSource.lineChartView(self, stringForLabel: .yAxisMin)
        yMinLabel.textAlignment = .right
        xMinLabel.text = dataSource.lineChartView(self, stringForLabel: .xAxisMin)
        xMinLabel.textAlignment = .center
        xMaxLabel.text = dataSource.lineChartView(self, stringForLabel: .xAxisMax)
        xMaxLabel.textAlignment = .right
    }

}