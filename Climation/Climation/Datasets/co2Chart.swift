//
//  co2Chart.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/27/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
import Charts

class co2Chart: UIView
{
    var dataSet = [co2Data]()
    var lineChartView = LineChartView()
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineChartView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        createDataSet()
        
        setChart()
        addSubview(lineChartView)
    }
    
    func setChart() {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataSet.count {
            let amount = Double(dataSet[i].amount)
            let year = Double(dataSet[i].year)
            let dataEntry = ChartDataEntry(x: amount!, y: year!)
            dataEntries.append(dataEntry)
        }
        
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataEntries.count {
            colors.append(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).withAlphaComponent(0.6))
        }
        
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .none
        pFormatter.maximumFractionDigits = 0
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Co2 Emissions")
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartData.setValueFormatter((DefaultValueFormatter(formatter: pFormatter)))
        lineChartView.chartDescription?.textAlign = .center
        lineChartView.chartDescription?.font = UIFont(name: "AvenirNext-DemiBold", size: 40)!
        lineChartView.data = lineChartData
        
    }
    
    
    func grabFromTxtFile(path: String, type: String)->String
    {
        if let filepath = Bundle.main.path(forResource: path, ofType: type) {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        return "error"
    }
    func createDataSet()
    {
        let dataString = grabFromTxtFile(path: "co2_annmean_gl", type: "txt")
        let lines = dataString.components(separatedBy: "\n")
        for line in lines{
            let values = line.components(separatedBy: ",")
            if(values.count == 2 )
            {
                let co2Obj = co2Data(year: values[0], amount: values[1])
                dataSet.append(co2Obj)
            }
        }
        print(dataSet)
    }
}
struct co2Data {
    var year: String
    var amount: String
}
