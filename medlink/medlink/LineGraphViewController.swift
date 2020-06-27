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
     var patients = [Patient] ()
    var patient : Patient!
    var accelerometre : Accelerometer!
    
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CHART TEMPERATURE
        updateGraphTemp()
        updateGraphAcc()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.patientService.getAll { (patients) in
            print(patients)
            //self.patient = patients.filter({$0._id == self.consultationDetail.patientUid}).first(where: (Patient) throws -> Bool)
            
            self.patient = patients.first(where: { (patient) -> Bool in
                patient._id == self.consultationDetail.patientUid
            })
            // filter just doctorId
            
            print("PATIENT")
            print (self.patient._id)
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
                
                print("DATE CONS")
                print(self.consultationDetail.date)
                print("DATE ACC")
                //print(self.accelerometre.date)
             
                
              }
        
               
          }
    func newInstance(detail: Consultation) -> LineGraphViewController {
          let view = LineGraphViewController()
          view.consultationDetail = detail
          return view
          
      }
      /*func newInstanceAcc(detail: Consultation) -> LineGraphViewController {
            let view = LineGraphViewController()
            view.consultationAccDetail = detail
            return view
        }*/
    
    func attribute ()  {
        if (accelerometre != nil){
            for word in accelerometre.accelerometerXValues {
                                print(word)
                            }
        }
      
    }
    
    // CHART TEMPERATURE
    var numbersTemp : [Double] = [30.32258,30.32258,30.32258,30.32258,30.32258,30.32258,30.96774,30.32258,30.96774,30.96774] //This is where we are going to store all the numbers. This can be a set of numbers that come from a Realm database, Core data, External API's or where ever else
    

  
    
    // CHART ACC
              // 1    2    3    4    5    6    7    8    9    10   seconds
    let personne = ["Nom": "Durand", "Prénom": "Maxime", "Adresse": "94 rue machin", "Ville": "Lille"]
    
    

   
   
    
    
    
       // [10.39505,11.0619,11.21881,9.375157,11.0619,10.66964,10.43428,10.12046,9.728197,10.15969]
    var tabY : [Double] = []
    //[-0.274586,-0.706079,-4.118793,-0.196133,-0.274586,-0.353039,-1.490611,0.353039,-0.549172,-0.313813]
    var tabZ : [Double] = [] //[-1.96133,-0.470719,1.569064,0.156906,-0.627626,-0.588399,-0.392266,-1.294478,-0.196133,-0.941438]

    
    // CHART TEMPERATURE
    func updateGraphTemp(){
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
        attribute()
        var lineChartEntryX  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        var lineChartEntryY  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        var lineChartEntryZ  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        if (self.accelerometre != nil){
            for i in 0..<accelerometre.accelerometerXValues.count {
                let value = ChartDataEntry(x: Double(i), y:accelerometre.accelerometerXValues [i]) // here we set the X and Y status in a data chart entry
                lineChartEntryX.append(value) // here we add it to the data set
            }
            //here is the for loop
            for i in 0..<accelerometre.accelerometerYValues.count {
                let value = ChartDataEntry(x: Double(i), y: accelerometre.accelerometerYValues[i]) // here we set the X and Y status in a data chart entry
                lineChartEntryY.append(value) // here we add it to the data set
            }
            //here is the for loop
            for i in 0..<accelerometre.accelerometerZValues.count {
                let value = ChartDataEntry(x: Double(i), y: accelerometre.accelerometerZValues[i]) // here we set the X and Y status in a data chart entry
                lineChartEntryZ.append(value) // here we add it to the data set
            }
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
