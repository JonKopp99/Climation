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

class co2Chart: UIView, ChartViewDelegate
{
    var dataSet = [co2Data]()
    var lineChartView = LineChartView()
    var descLabel = UILabel()
    var titlelabel = UILabel()
    var sideLabel = UILabel()
    var bottomLabel = UILabel()
    var infoButton = UIButton()
    var textFile = String()
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func loadVIew()
    {
        titlelabel = UILabel(frame: CGRect(x:20, y: 0, width: bounds.width - 40, height: 50))
        titlelabel.text = "Global Atmospheric CO\u{2082}"
        titlelabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        titlelabel.font = UIFont.systemFont(ofSize: 20)
        titlelabel.textAlignment = .center
        //titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.sizeToFit()
       
        titlelabel.frame.origin.x = bounds.width / 2 - titlelabel.frame.width / 2
        addSubview(titlelabel)
        
        infoButton.frame = CGRect(x: titlelabel.frame.maxX + 10, y: titlelabel.frame.minY + 2.5, width: 20, height: 20)
        infoButton.setImage(#imageLiteral(resourceName: "icons8-info-50 (1)"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoPressed), for: .touchUpInside)
        addSubview(infoButton)
        
        lineChartView.delegate = self
        lineChartView.frame = CGRect(x: 15, y: 35, width: bounds.width - 30, height: bounds.height - 50)
        createDataSet()
        lineChartView.alpha = 0.0
        addSubview(lineChartView)
        setChart()
        UIView  .animate(withDuration: 0.5, animations: {
            self.lineChartView.alpha = 1.0
        })
        
        sideLabel = UILabel(frame: CGRect(x:-30, y: lineChartView.frame.midY - 40, width: 80, height: 15))
        sideLabel.text = "Year"
        //sideLabel.numberOfLines = 4
        sideLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sideLabel.font = UIFont.systemFont(ofSize: 15)
        sideLabel.textAlignment = .left
        sideLabel.adjustsFontSizeToFitWidth = true
        sideLabel.transform = CGAffineTransform(rotationAngle: .pi / -2)
        addSubview(sideLabel)
        
        bottomLabel = UILabel(frame: CGRect(x:20, y: lineChartView.frame.maxY + 2.5, width: bounds.width - 40, height: 12))
        bottomLabel.text = "CO\u{2082} Parts Per Million"
        bottomLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        bottomLabel.textAlignment = .center
        bottomLabel.adjustsFontSizeToFitWidth = true
        addSubview(bottomLabel)
        
        descLabel.frame = CGRect(x:10, y: titlelabel.frame.maxY + 2.5, width: bounds.width - 20, height: 0)
        descLabel.text = "This graph shows yearly mean carbon dioxide globally. The Global Monitoring Division of NOAA has measured CO\u{2082} and other greenhouse gases for several decades at a globally distributed network of air sampling sites."
        descLabel.numberOfLines = 4
        descLabel.textColor = #colorLiteral(red: 0.7467742758, green: 0.9136630076, blue: 0.9764705896, alpha: 1)
        descLabel.font = UIFont(name: "Helvetica-Italic", size: 15.0)
        descLabel.textAlignment = .center
        descLabel.adjustsFontSizeToFitWidth = true
        addSubview(descLabel)
        
    }
    @objc func infoPressed()
    {
        if(descLabel.frame.height == 0)
        {
            addSubview(descLabel)
            infoButton.setImage(#imageLiteral(resourceName: "icons8-info-50 (1)").mask(with: #colorLiteral(red: 0.7467742758, green: 0.9136630076, blue: 0.9764705896, alpha: 1)), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.descLabel.frame = CGRect(x:10, y: self.titlelabel.frame.maxY + 2.5, width: self.bounds.width - 20, height: 100)
                self.lineChartView.frame = CGRect(x: 45, y: 135, width: self.bounds.width - 90, height: self.bounds.height - 150)
                 self.sideLabel.frame = CGRect(x:0, y: self.sideLabel.frame.minY + 50, width: 80, height: 80)
                
                 })
        }else{
            infoButton.setImage(#imageLiteral(resourceName: "icons8-info-50 (1)"), for: .normal)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.descLabel.frame = CGRect(x:10, y: self.titlelabel.frame.maxY + 5, width: self.bounds.width - 20, height: 0)
                
                self.lineChartView.frame = CGRect(x: 15, y: 35, width: self.bounds.width - 30, height: self.bounds.height - 50)
                self.sideLabel.frame = CGRect(x:-30, y: self.sideLabel.frame.minY - 50, width: 80, height: 80)
            }, completion: { (finished: Bool) in
                self.descLabel.removeFromSuperview()
            })
        }
    }
    
    func setChart() {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataSet.count {
            let amount = Double(dataSet[i].amount)
            let year = Double(dataSet[i].year)
            let dataEntry = ChartDataEntry(x: amount!, y: year!)
            //let dataEntry = ChartDataEntry(x: year!, y: amount!)
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
        lineChartDataSet.highlightColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
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
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        print(entry.x, entry.y)
        titlelabel.removeFromSuperview()
            //self.lineChartView.frame = CGRect(x: 5, y: 65, width: self.bounds.width - 10, height: self.bounds.height - 110)
        titlelabel = UILabel(frame: CGRect(x:20, y: 0, width: self.bounds.width - 40, height: 50))
        titlelabel.numberOfLines = 2
        titlelabel.textAlignment = .center
        titlelabel.text = "Global Atmospheric CO\u{2082}\nYear: \(Int(entry.y)) CO\u{2082}ppm: \(Int(entry.x))"
        addSubview(self.titlelabel)
            
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeHighlights()
    }
    
    func removeHighlights()
    {
        lineChartView.highlightValues([Highlight]())
        titlelabel.removeFromSuperview()
        titlelabel = UILabel(frame: CGRect(x:20, y: 0, width: bounds.width - 40, height: 50))
        titlelabel.text = "Global Atmospheric CO\u{2082}"
        titlelabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        titlelabel.font = UIFont.systemFont(ofSize: 20)
        titlelabel.textAlignment = .center
        //titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.sizeToFit()
        
        titlelabel.frame.origin.x = bounds.width / 2 - titlelabel.frame.width / 2
        addSubview(titlelabel)
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
        let dataString = grabFromTxtFile(path: textFile, type: "txt")
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
