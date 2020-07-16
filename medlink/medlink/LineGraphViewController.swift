//
//  LineGraphViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 20/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LineGraphViewController: UIViewController {

    @IBOutlet var btn_refresh: UIButton!
    @IBOutlet var textField_observations: UITextField!
    @IBOutlet var label_diagnostics: UILabel!
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var label_stddv: UILabel!
    @IBOutlet var label_tempavg: UILabel!
    @IBOutlet var label_tempmax: UILabel!
    @IBOutlet var label_tempmin: UILabel!
    @IBOutlet var label_stddv_val: UILabel!
    @IBOutlet var label_tempavg_val: UILabel!
    @IBOutlet var label_tempmax_val: UILabel!
    @IBOutlet var label_tempmin_val: UILabel!
    var id : String?
    var editTitle: String?
    var consultationDetail: Consultation!
    var consultationAccDetail: Consultation!
    var tabX = [Double] ()
    var tabY = [Double] ()
    var tabZ = [Double] ()
    var numbersTemp = [Double] ()
       
      
    var temperatureService: TemperatureService{
              //return PatientMockService()
           return TemperatureAPIService()
       }
    var consultationService: ConsultationService{
                 //return PatientMockService()
              return ConsultationAPIService()
          }
       
       var accelerometerService: AccelerometerService{
                 //return PatientMockService()
              return AccelerometerAPIService()
          }
               
     var patientService: PatientService{
                  //return PatientMockService()
               return PatientAPIService()
           }
    
    // CHART TEMPERATURE
    @IBOutlet var chtChart: LineChartView!
    @IBOutlet var btnbutton: UIButton!
    @IBOutlet var txtTextBox: UITextField!
    
    // CHART ACC
    @IBOutlet var chtChartAcc: LineChartView!
     var accelerometres = [Accelerometer] ()
    var temperatures = [Temperature] ()
     var patients = [Patient] ()
    var patient : Patient!
    var accelerometre : Accelerometer!
    var temperature : Temperature!
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
    func newInstance(detail: Consultation) -> LineGraphViewController {
           let view = LineGraphViewController()
           view.consultationDetail = detail
           return view
           
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_refresh.alpha = 0
        label_diagnostics.text = NSLocalizedString("diagnostics", comment: "")
        btn_save.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        btn_save.contentHorizontalAlignment = .right
        
        label_stddv.text = NSLocalizedString("stddv", comment: "")
        label_tempavg.text = NSLocalizedString("avg", comment: "")
        label_tempmax.text = NSLocalizedString("max", comment: "")
        label_tempmin.text = NSLocalizedString("min", comment: "")
        // CHART TEMPERATURE
       // updateGraphTemp()
       // updateGraphAcc()
        textField_observations.text = consultationDetail.description
        id = consultationDetail._id
        editTitle = consultationDetail.title
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.patientService.getAll { (patients) in
            print(patients)
            
                self.patient = patients.first(where: { (patient) -> Bool in
                        patient._id == self.consultationDetail.patientUid
                    })
                    // filter just doctorId
                    print("PATIENT")
                    print (self.patient._id)
                }
            
            
            self.temperatureService.getAll { (temperatures) in
                        print(temperatures)
                
                if(self.patient != nil){
                    self.temperatures = temperatures.filter({$0.deviceID == self.patient.objetUid})
                                 // filter just doctorId
                    print(self.patient.objetUid)
                             print("TEMPERATURE")

                             print (self.temperatures.count)
                                 print(self.temperatures)
                             self.temperature = self.temperatures.last(where: { (temperature) -> Bool in
                                 temperature.date == self.consultationDetail.date
                                 
                             })
                   // print(self.temperature)
                             print("DATE CONS")
                             print(self.consultationDetail.date)
                             print("DATE TEMP")
                            // print(self.temperature.date)
                             
                             if (self.temperature != nil){
                                 
                                 for i in 0..<self.temperature.tempValues.count {
                                     let value = self.temperature.tempValues[i]
                                     print(i)
                                     self.numbersTemp.append(value)
                                 }
                                print(self.numbersTemp)
                                  self.updateGraphTemp()
                                self.sd()
                                self.moyenne_min_max()
                             }
                    
                             
                             }
                }
                
               self.accelerometerService.getAll { (accelerometres) in
                  print(accelerometres)
                if(self.patient != nil){
                    self.accelerometres = accelerometres.filter({$0.deviceID == self.patient.objetUid})
                                    // filter just doctorId
                                  print("ACCELEROMETRE")

                                  print (self.accelerometres.count)
                                    print(self.accelerometres)
                                  self.accelerometre = self.accelerometres.last(where: { (accelerometre) -> Bool in
                                      accelerometre.date == self.consultationDetail.date
                                  })
                                  
                                 // print("DATE CONS")
                                 // print(self.consultationDetail.date)
                                 // print("DATE ACC")
                                  //print(self.accelerometre.date)
                               
                                  if (self.accelerometre != nil){
                                      
                                      for i in 0..<self.accelerometre.accelerometerXValues.count {
                                          let value = self.accelerometre.accelerometerXValues[i]
                                          //print(i)
                                          self.tabX.append(value)
                                      }
                                     for i in 0..<self.accelerometre.accelerometerYValues.count {
                                         let value = self.accelerometre.accelerometerYValues[i]
                                         self.tabY.append(value)
                                     }
                                      for i in 0..<self.accelerometre.accelerometerZValues.count {
                                          let value = self.accelerometre.accelerometerZValues[i]
                                          self.tabZ.append(value)
                                      }
                                     self.updateGraphAcc()
                                     
                                  }
                                  
                }
              
              }
               
        
                
                 
               
          }
 

    func sd() {
        let expression = NSExpression(forFunction: "stddev:", arguments: [NSExpression(forConstantValue: numbersTemp)])
        let standardDeviation = expression.expressionValue(with: nil, context: nil)
        print("******** SD = \(standardDeviation!)")
        self.label_stddv_val.text = (standardDeviation! as AnyObject).stringValue
    }
    
    
    
    
    
    func moyenne_min_max() {
        let sumArray = Double(numbersTemp.reduce(0, +))
        let avgArrayValue = Double (Double(sumArray) / Double(Int(numbersTemp.count)) )
        print("******** AVG = \(avgArrayValue)")
        self.label_tempavg_val.text = String(avgArrayValue)
        self.label_tempmin_val.text = String(self.numbersTemp.min()!)
        self.label_tempmax_val.text = String(self.numbersTemp.max()!)
    }
    
    // CHART TEMPERATURE
    func updateGraphTemp(){
        print("tmps values")
        print(numbersTemp)
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        for i in 0..<numbersTemp.count {
            let value = ChartDataEntry(x: Double(i), y: numbersTemp[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }

        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Temperature") //Here we convert lineChartEntry to a LineChartDataSet
        line1.setCircleColors(.blue)
        line1.circleRadius = 4
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart.animate(xAxisDuration: 1.0, easingOption: .linear)
        
    }
    
    // CHART ACC
    func updateGraphAcc(){
        //viewDidAppear(true)
       // print("tabx")
      //  print(tabX)
        var lineChartEntryX  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        var lineChartEntryY  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        var lineChartEntryZ  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
            for i in 0..<tabX.count {
                let value = ChartDataEntry(x: Double(i), y:tabX[i]) // here we set the X and Y status in a data chart entry
                lineChartEntryX.append(value) // here we add it to the data set
            }
            //here is the for loop
            for i in 0..<tabY.count {
                let value = ChartDataEntry(x: Double(i), y: tabY[i]) // here we set the X and Y status in a data chart entry
                lineChartEntryY.append(value) // here we add it to the data set
            }
            //here is the for loop
            for i in 0..<tabZ.count {
                let value = ChartDataEntry(x: Double(i), y: tabZ[i]) // here we set the X and Y status in a data chart entry
                lineChartEntryZ.append(value) // here we add it to the data set
            }
        
        //here is the for loop
        

        let line1 = LineChartDataSet(entries: lineChartEntryX, label: "X") //Here we convert lineChartEntry to a LineChartDataSet
        line1.setCircleColors(.blue)
        line1.circleRadius = 4
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        let line2 = LineChartDataSet(entries: lineChartEntryY, label: "Y") //Here we convert lineChartEntry to a LineChartDataSet
        line2.setCircleColors(.green)
        line2.circleRadius = 4
        line2.colors = [NSUIColor.green] //Sets the colour to green
        let line3 = LineChartDataSet(entries: lineChartEntryZ, label: "Z") //Here we convert lineChartEntry to a LineChartDataSet
        line3.setCircleColors(.red)
        line3.circleRadius = 4
        line3.colors = [NSUIColor.red] //Sets the colour to red

        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        data.addDataSet(line2) //Adds the line to the dataSet
        data.addDataSet(line3) //Adds the line to the dataSet
        

        chtChartAcc.data = data //finally - it adds the chart data to the chart and causes an update
        //chtChart.chartDescription?.text = "Temperature" // Here we set the description for the graph
        chtChartAcc.animate(xAxisDuration: 1.0, easingOption: .linear)
    }
    
    // CHART TEMPERATURE
  
    
    @IBAction func btn_save(_ sender: Any) {
       // let observations = textField_observations.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        guard
                     let id = id,
            //let title = editTitle,
            let description = textField_observations.text,
                   //  let date = DateText.text,
                     //let timeStart = TimeStartText.text,
                  
                     
                        // id.count > 0,
                         //title.count > 0,
                         description.count > 0
                       //  date.count > 0,
                       //  timeStart.count > 0,
                      //   date.count > 0,
                       //  timeStart.count > 0
                         
                     else {
                         
                         self.displayError(message: NSLocalizedString("missing_field", comment: ""))
                         return
                     }
                        
                           //let email = emailTextField.text,
        self.consultationService.edit(id: id, title: consultationDetail.title, description: description, doctorUid: consultationDetail.doctorUid, patientUid: consultationDetail.patientUid, date: consultationDetail.date, appointmentTime: consultationDetail.appointmentTime, timeEnd: consultationDetail.timeEnd){
                  (success) in
                  
              }
                    
                         let confirmationAlert = UIAlertController(title: NSLocalizedString("success", comment: ""), message: NSLocalizedString("modif_success", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                                   confirmationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil ))
                                                    
                                                 
                                                   self.present(confirmationAlert, animated: true, completion: nil)
       
    }
    func displayError(message: String) {
          let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel))
          self.present(alert, animated: true)
      }
      
    @IBAction func btn_refresh(_ sender: Any) {
        
    }
    

}




// two next lines must be fixed
       //textField_observations.text = consultationDetail.description // bien faire appel api
       
       
       // A FAIRE
       /*guard let userID = Auth.auth().currentUser?.uid else { return }
       let db = Firestore.firestore()
       let userRef = db.collection("consultations").document(userID)
       
       // Set the "capital" field of the city 'DC'
       userRef.updateData([
           "description": observations
       ]) { err in
           if let err = err {
               print("Error updating document: \(err)")
           } else {
               print("Document successfully updated")
               let alertController = UIAlertController(title: nil, message: "Observation was sucessfully updated", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
               self.present(alertController, animated: true, completion: nil)
           }
       }
        */
