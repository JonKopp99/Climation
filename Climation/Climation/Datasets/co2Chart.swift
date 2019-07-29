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
        
        let label = UILabel(frame: CGRect(x:20, y: 0, width: bounds.width - 40, height: 30))
        label.text = "Global Atmospheric CO\u{2082}"
        label.textColor = #colorLiteral(red: 0.6622745241, green: 0.8905576081, blue: 0.9764705896, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 20.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        lineChartView.frame = CGRect(x: 5, y: 35, width: bounds.width - 10, height: bounds.height)
        createDataSet()
        lineChartView.alpha = 0.0
        addSubview(lineChartView)
        setChart()
        UIView  .animate(withDuration: 0.5, animations: {
            self.lineChartView.alpha = 1.0
            })
    }
    func setChart() {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataSet.count {
            let amount = Double(dataSet[i].amount)
            let year = Double(dataSet[i].year)
            //let dataEntry = ChartDataEntry(x: amount!, y: year!)
            let dataEntry = ChartDataEntry(x: year!, y: amount!)
            dataEntries.append(dataEntry)
        }
        
        
        var colors: [UIColor] = []
        
        for i in 0..<dataEntries.count {
            let co2Amount = Double(dataSet[i].amount)!
            let color = colorByAmount(amount: co2Amount)
            
            
            colors.append(color)
        }
        
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .none
        pFormatter.maximumFractionDigits = 0
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "CO\u{2082} Parts Per Million")
        lineChartDataSet.colors = colors
        lineChartDataSet.circleRadius = 3.5
        lineChartDataSet.lineWidth = 4
        lineChartDataSet.setCircleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8))
        lineChartDataSet.valueFont = UIFont(name: "Helvetica-Light", size: 10)!
        lineChartDataSet.valueTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.0)
        let gradientColors = [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor,#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor] as CFArray
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: [1.0,0.0])else{ print(" Gradient error"); return}
        lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        lineChartDataSet.drawFilledEnabled = true
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartData.setValueFormatter((DefaultValueFormatter(formatter: pFormatter)))
        lineChartView.chartDescription?.textAlign = .center
        lineChartView.data = lineChartData
//        lineChartView.legend.font = UIFont(name: "Helvetica", size: 15)!
//        lineChartView.legend.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        lineChartView.legend.horizontalAlignment = .left
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.legend.enabled = false
        //lineChartView.setViewPortOffsets(left: 20, top: 20, right: 20, bottom: 20)
        
        
    }
    func colorByAmount(amount: Double)->UIColor
    {
        var color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)]
        if amount < 355 {color = colors[0]}
            else if amount < 370 {color = colors[1]}
                else if amount < 380 {color = colors[2]}
                    else if amount < 390 {color = colors[3]}
                        else if amount < 400 {color = colors[4]}
        else {color = colors[5]}
        return color
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
        let dataString = grabFromTxtFile(path: "co2_annmean_10year", type: "txt")
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
