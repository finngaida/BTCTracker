//
//  ViewController.swift
//  BTCTracker
//
//  Created by Finn Gaida on 08.10.17.
//  Copyright © 2017 Finn Gaida. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet var chart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    func loadData() {

        var values = [ChartDataEntry]()

        for i in 0..<13 {
            API.shared.getData(timestamp: "\(i)", response: { value in
                if let val = value {
                    values.append(ChartDataEntry(x: Double(i), y: val))
                }
                if i == 12 {
                    let set = LineChartDataSet(values: values, label: "BTC Prices")
                    set.colors = [NSUIColor.red]
                    let data = LineChartData(dataSet: set)
                    self.chart.data = data
                    self.chart.chartDescription?.text = "BTC <-> EUR"
                }
            })
        }
    }

}

