//
//  LineGraphViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 20/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Charts

class LineGraphViewController: UIViewController {

    // CHART TEMPERATURE
    @IBOutlet var chtChart: LineChartView!
    @IBOutlet var btnbutton: UIButton!
    @IBOutlet var txtTextBox: UITextField!
    
    // CHART ACCELEROMETRE
    @IBOutlet var chartView: ScatterChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    
    /*
    @IBAction func btnbutton(_ sender: Any) {
        let input  = Double(txtTextBox.text!) //gets input from the textbox - expects input as double/int
        numbers.append(input!) //here we add the data to the array.
        updateGraph()
    }
    */
    
    // CHART TEMPERATURE
    var numbersTemp : [Double] = [35.4, 40.42, 43.14, 35.82, 37.3, 30.62, 35.99, 35.24, 37.83, 40.44, 38.49] //This is where we are going to store all the numbers. This can be a set of numbers that come from a Realm database, Core data, External API's or where ever else

    // CHART TEMPERATURE
    func updateGraphTemp(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        
        //here is the for loop
        for i in 0..<numbersTemp.count {

            let value = ChartDataEntry(x: Double(i), y: numbersTemp[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }

        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Temperature") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue

        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        

        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        //chtChart.chartDescription?.text = "Temperature" // Here we set the description for the graph
    }
    
    // CHART TEMPERATURE
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CHART TEMPERATURE
        updateGraphTemp()
        
        // CHART ACCELEROMETRE
        self.title = "Scatter Chart"
        /*self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        
        chartView.delegate = self
        */
        chartView.chartDescription?.enabled = false
        
        //chartView.dragEnabled = true
        //chartView.setScaleEnabled(true)
        //chartView.maxVisibleCount = 200
        //chartView.pinchZoomEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        //l.xOffset = 5
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.axisMinimum = -10
        leftAxis.axisMaximum = 10
        
        let rightAxis = chartView.rightAxis
        rightAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        rightAxis.axisMinimum = -10
        rightAxis.axisMaximum = 10
        
        //chartView.rightAxis.enabled = false
        
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.axisMinimum = -1
        xAxis.axisMaximum = 11
        
        sliderX.value = 45
        sliderY.value = 100
        slidersValueChanged(nil)
        
        
        
        // Do any additional setup after loading the view.
    }
    
     func updateChartData() {
        /*if self.shouldHideData {
            chartView.data = nil
            return
        }
        */
        // int(5) = 5 données
        // range  =
        self.setDataCount(Int(5), range: 0)
    }
    
    // CHART ACCELEROMETRE-
    func setDataCount(_ count: Int, range: Double) {
        let values1 = (0..<count).map { (i) -> ChartDataEntry in
            //let val = Double(range)
            return ChartDataEntry(x: Double(i), y: Double(count))
        }
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            //let val = Double(range)
            return ChartDataEntry(x: Double(i) + 0.33, y: Double(count))
        }
        let values3 = (0..<count).map { (i) -> ChartDataEntry in
            //let val = Double(range)
            return ChartDataEntry(x: Double(i) + 0.66, y: Double(count))
        }

        
        let set1 = ScatterChartDataSet(entries: values1, label: "DS 1")
        set1.setScatterShape(.circle)
        set1.setColor(ChartColorTemplates.colorful()[0])
        set1.scatterShapeSize = 6
        
        let set2 = ScatterChartDataSet(entries: values2, label: "DS 2")
        set2.setScatterShape(.circle)
        set2.scatterShapeHoleColor = ChartColorTemplates.colorful()[3]
        set2.scatterShapeHoleRadius = 3.5
        set2.setColor(ChartColorTemplates.colorful()[1])
        set2.scatterShapeSize = 6
        
        let set3 = ScatterChartDataSet(entries: values3, label: "DS 3")
        set3.setScatterShape(.circle)
        set3.setColor(ChartColorTemplates.colorful()[2])
        set3.scatterShapeSize = 6
        
        let data = ScatterChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))

        chartView.data = data
    }
    /*
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
    */
    
    // CHART ACCELEROMETRE
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        updateChartData()
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
