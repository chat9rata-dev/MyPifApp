//
//  AutoViewController.swift
//  pifapp
//
//  Created by srihari ponnapalli on 09/05/20.
//  Copyright © 2020 Arth. All rights reserved.
//

import UIKit
import Charts

class AutoViewController: UIViewController {

    @IBOutlet var preferredButton: UIButton!
    @IBOutlet var standardButton: NSLayoutConstraint!
    //var standardButton: UIButton!
    
//    var preferredButton: UIButton!
//
//
    var barChartView: BarChartView!
    
    var screenSize: CGSize?
    
    let months = ["02/18", "02/19", "02/20", "02/21", "02/22"]
    let mounthDataValues = [2.1, 4.2, -2.3, -2.5, -1.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.screenSize = UIScreen.main.bounds.size
        
        barChartView = BarChartView(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height - 300))
        self.view.addSubview(barChartView)
        barChartView.backgroundColor = .white
        print(self.preferredButton as Any)
        // Do any additional setup after loading the view.
//        currentLabelOutlet.text = "Current PF: 432,078,389"
//        autoDailylabelOutlet.text = "Auto Daily Policy Gains/Losses in (K)"
        //self.perform(#selector(addButtons), with: self, afterDelay: 1.0)
        
        setupChart()
        loadChartData()
    }
    
    @objc func addButtons(){
//        standardButton = UIButton(frame: CGRect(x: 30, y: 120, width: screenSize!.width/2 - 45 , height: 30))
//        standardButton.setTitle("STANDARD", for: UIControl.State.normal)
//        standardButton.backgroundColor = .lightText
//
//        preferredButton = UIButton(frame: CGRect(x: screenSize!.width/2 + 15, y: 120, width: screenSize!.width/2 - 45 , height: 30))
//        preferredButton.setTitle("PREFERRED", for: UIControl.State.normal)
//        preferredButton.backgroundColor = .lightText
//
////        self.view.addSubview(preferredButton)
////        self.view.addSubview(standardButton)
//
//        self.view.bringSubviewToFront(preferredButton)
//        self.view.bringSubviewToFront(standardButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func buttonActions(_ sender: UIButton) {
        switch sender {
        case preferredButton:
            barChartView.animate(xAxisDuration: 2, yAxisDuration: 1)
        case standardButton:
            barChartView.animate(xAxisDuration: 1, yAxisDuration: 2)
        default:
            break
        }
        barChartView.animate(xAxisDuration: 2, yAxisDuration: 1)
    }
    
    func setupChart() {
            barChartView.pinchZoomEnabled = false
            barChartView.dragEnabled = false
            barChartView.setScaleEnabled(false)
            barChartView.drawValueAboveBarEnabled = true
            barChartView.data?.highlightEnabled = false
            barChartView.rightAxis.enabled = false
            barChartView.legend.enabled = false
            
            let xAxis = barChartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.drawAxisLineEnabled = false
            xAxis.drawGridLinesEnabled = false
            xAxis.granularity = 1
            xAxis.labelCount = 10
            xAxis.valueFormatter = self // as? IAxisValueFormatter
            xAxis.spaceMax = 0.8
            xAxis.spaceMin = 0.8
            xAxis.labelFont = UIFont(name: "Helvetica Neue", size: 13)!
            
            let leftAxis = barChartView.leftAxis
            leftAxis.enabled = false
    //        leftAxis.drawGridLinesEnabled = false
    //        leftAxis.drawAxisLineEnabled = true
    //        leftAxis.drawZeroLineEnabled = true
    //        leftAxis.drawLabelsEnabled = true
    //        leftAxis.axisLineWidth = 2
    //        leftAxis.zeroLineWidth = leftAxis.axisLineWidth
    //        leftAxis.zeroLineColor = leftAxis.axisLineColor
    //        leftAxis.valueFormatter = self as? IAxisValueFormatter
            
            
            let rightAxis = barChartView.rightAxis
            rightAxis.enabled = false
            
            
        }
        
        private func loadChartData() {
            let barWidth = 0.7
            
            var colorArray: [UIColor] = []
            let yVals = (0..<mounthDataValues.count).map { (i) -> BarChartDataEntry in
                
                if mounthDataValues[i] < 0 {
                    colorArray.append(UIColor.red)
                } else {
                    colorArray.append(UIColor.green)
                }
                
                let entry = BarChartDataEntry(x: Double(i), y: mounthDataValues[i], icon: nil)
                return entry
            }
            
            
            let barChartDataSet = BarChartDataSet(entries: yVals, label: "KETAN")
            barChartDataSet.drawValuesEnabled = true
            barChartDataSet.valueFont = UIFont(name: "Helvetica Neue", size: 13)!
            
            let data = BarChartData(dataSet: barChartDataSet)
            // data.setValueFormatter(self)
            data.barWidth = barWidth
            data.highlightEnabled = false
            
            barChartView.data = data
            
            barChartDataSet.setColors(colorArray, alpha: 1)
        }
        
        
        
        
    }

    extension AutoViewController: IValueFormatter {
        // IValueFormatter
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            return "\(value)"
        }
    }


    extension AutoViewController: IAxisValueFormatter {
        // IAxisValueFormatter
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return months[Int(value)]
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
