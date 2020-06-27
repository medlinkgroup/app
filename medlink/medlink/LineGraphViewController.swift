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

    @IBOutlet var textField_observations: UITextField!
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var label_patient_lastname: UILabel!
    
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
        
        // CHART TEMPERATURE
       // updateGraphTemp()
       // updateGraphAcc()
        
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
                                 
                                 
                             }
                    
                             
                             }
                }
                
               self.accelerometerService.getAll { (accelerometres) in
                  print(accelerometres)
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
    }
    
    // CHART TEMPERATURE
  
    
    @IBAction func btn_save(_ sender: Any) {
        let observations = textField_observations.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        // two next lines must be fixed
        textField_observations.text = consultationDetail.description // bien faire appel api
        label_patient_lastname.text = consultationDetail.patientUid // faire patient.uid->lastname
        
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
    }
    

}
