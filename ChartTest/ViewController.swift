//
//  ViewController.swift
//  ChartTest
//
//  Created by John Grant on 2015-05-27.
//  Copyright (c) 2015 jgapps. All rights reserved.
//

import UIKit
import FSLineChart
import JBChartView

extension UIColor {

    class func chartBackground() -> UIColor {
        return UIColor(white: 0.95, alpha: 1)
    }

    class func chartPrimaryColor() -> UIColor {
        return UIColor.orangeColor()
    }

    class func chartLineColor() -> UIColor {
        return UIColor.lightGrayColor()
    }

    class func chartGridColor() -> UIColor {
        return UIColor(white: 0.85, alpha: 1)
    }

}

class ViewController: UIViewController {

    let data = [5,3,4]
    let chartPadding = 20
    var chartWidth:Int {
        get {
            return Int(self.view.bounds.size.width) - 2*self.chartPadding
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.chartBackground()
        self.addFSLineChart()
//        self.addJBChartView()
    }
}

//MARK: FSLineChart
extension ViewController {
    func addFSLineChart() {
        let chart = FSLineChart(frame: CGRect(x: self.chartPadding, y: 20, width: self.chartWidth, height: 300))
        self.view.addSubview(chart)
        self.styleChart(chart)
        self.styleValueLabels(chart)
        self.styleDataPoints(chart)
        self.addChartData(chart)
    }

    func styleChart(chart: FSLineChart) {
        chart.backgroundColor = UIColor.chartBackground()
        chart.color = UIColor.chartLineColor()
        chart.fillColor = UIColor.clearColor()
        chart.axisColor = UIColor.chartBackground()
        chart.bezierSmoothing = false
        chart.innerGridColor = UIColor.chartGridColor()
    }

    func styleValueLabels(chart: FSLineChart) {
        chart.valueLabelTextColor = UIColor.chartPrimaryColor()
        chart.valueLabelBackgroundColor = UIColor.clearColor()
        chart.valueLabelPosition = .Left
        chart.valueLabelFont = UIFont.boldSystemFontOfSize(12)
    }

    func styleDataPoints(chart: FSLineChart) {
        chart.displayDataPoint = true
        chart.dataPointColor = UIColor.chartPrimaryColor()
        chart.dataPointBackgroundColor = UIColor.chartPrimaryColor()
        chart.dataPointRadius = 4
    }

    func addChartData(chart: FSLineChart) {
        chart.verticalGridStep = 5
        chart.horizontalGridStep = 3
        chart.labelForIndex = { index in
           return nil
        }
        chart.labelForValue = { value in
            return "\(Int(value))"
        }

        chart.setChartData(self.data)
    }
}

//MARK: JBChartView
extension ViewController {
    func addJBChartView() {
        let frame = CGRect(x: self.chartPadding, y: 320, width: self.chartWidth, height: 300)
        let chart = JBLineChartView(frame: frame)
        chart.dataSource = self
        chart.delegate = self
        self.view.addSubview(chart)
        chart.reloadData()
    }
}

extension ViewController : JBLineChartViewDataSource {

    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }

    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return UInt(self.data.count)
    }

    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }

}

extension ViewController : JBLineChartViewDelegate {

    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(self.data[Int(horizontalIndex)])
    }

}

