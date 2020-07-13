//
//  AddConsultationViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddConsultationViewController: UIViewController {

    
    @IBOutlet var label_add_consultation: UILabel!
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var PatientText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    @IBOutlet weak var TimeStartText: UITextField!
    @IBOutlet weak var TimeEndText: UITextField!
    
    @IBOutlet var btn_add_consultation: UIButton!
    
    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_patient: UILabel!
    @IBOutlet var label_description: UILabel!
    @IBOutlet var label_date: UILabel!
    @IBOutlet var label_time_start: UILabel!
    @IBOutlet var label_time_end: UILabel!
    
    let patientPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let timeStartPicker = UIDatePicker()
    let timeEndPicker = UIDatePicker()
    var patientService: PatientService{
           return PatientAPIService()
       }
    var patients = [Patient] ()
    var UidDoc : String?
    var selectedPatientId : String?
    var selectedPatientName: String?
    let db = Firestore.firestore()
    
    var consultationService: ConsultationService{
        return ConsultationAPIService()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.patientService.getAll { (patients) in
            print(patients)
            print(". . . . . . . . \(self.UidDoc)")
            self.patients = patients.filter({$0.doctorUid == self.UidDoc})
            // filter just doctorId
            
            print(self.patients)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        label_add_consultation.text = NSLocalizedString("add_consultation", comment: "")
        btn_add_consultation.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        label_title.text = NSLocalizedString("title_consultation", comment: "")
        label_patient.text = NSLocalizedString("patient", comment: "")
        label_description.text = NSLocalizedString("description", comment: "")
        label_date.text = NSLocalizedString("date", comment: "")
        label_time_start.text = NSLocalizedString("time_start", comment: "")
        label_time_end.text = NSLocalizedString("time_end", comment: "")

        if let user = Auth.auth().currentUser {
                   // user connect
                   let docRef = db.collection("users").document(user.uid)
            self.UidDoc = user.uid
                   
                  docRef.getDocument { (document, error) in
                  if let document = document, document.exists {
                      //print(document.data()!)
                   self.UidDoc = document["uid"] as? String
                       
                      } else {
                          print("Document does not exist")
                      }
                  }
               } else {
                   fatalError(" Erreur : aucun user connect")
               }
        
        self.TitleText.delegate = self
        self.DescriptionText.delegate = self
        self.PatientText.delegate = self
        self.DateText.delegate = self
        self.TimeStartText.delegate = self
        self.TimeEndText.delegate = self
        createPatientPicker()
        createDatePicker()
        createTimeStartPicker()
        createTimeEndPicker()
    }
    
    @IBAction func add_patient_btn(_ sender: Any) {
        guard let title = TitleText.text,
              let patient = PatientText.text,
              let description = DescriptionText.text,
              let date = DateText.text,
              let timeStart = TimeStartText.text,
              let timeEnd = TimeEndText.text,
              let creatorUid = UidDoc,
            
              title.count > 0,
              description.count > 0,
              patient.count > 0,
              date.count > 0,
              timeStart.count > 0,
              timeEnd.count > 0,
              creatorUid.count > 0
              else {
                self.displayError(message: NSLocalizedString("missing_field", comment: ""))
            return
        }
         
       
        self.consultationService.create(title: title,                                       description: description,
                                        doctorUid: creatorUid,patientUid: selectedPatientId ?? "",
                                        date: date,
                                      appointmentTime: timeStart,
                                      timeEnd: timeEnd )
            { (success) in
          
                print(success)
               
          
            }
            
            let confirmationAlert = UIAlertController(title: NSLocalizedString("done", comment: ""), message: NSLocalizedString("add_success", comment: ""), preferredStyle: UIAlertController.Style.alert)
                           confirmationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil ))
                            
                         
                           self.present(confirmationAlert, animated: true, completion: nil)
          
        }
        
    

func displayError(message: String) {
       let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel))
       self.present(alert, animated: true)
   }
    func createPatientPicker(){
        //categoryPicker.tag = 1
                PatientText.inputView = patientPicker
                patientPicker.delegate = self
                let toolBar = UIToolbar()
                toolBar.sizeToFit()
                let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self,
                action: #selector(AddConsultationViewController.donePatientPicker))
                toolBar.setItems([doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                PatientText.inputAccessoryView = toolBar
    }
    @objc func donePatientPicker() {
        
        view.endEditing(true)
                
    }
    func createDatePicker(){
         // datePicker.datePickerMode = .date
          let toolbar = UIToolbar()
           toolbar.sizeToFit()
          let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: #selector(AddPatientViewController.donedatePicker ))
          toolbar.setItems([doneButton], animated: true)
          toolbar.isUserInteractionEnabled = true
      DateText.inputAccessoryView = toolbar
      DateText.inputView = datePicker
      datePicker.minimumDate = Date()
          
      }
      @objc func donedatePicker(){

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
          DateText.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
      }
    func createTimeStartPicker(){
           timeStartPicker.datePickerMode = .time
           let toolbar = UIToolbar()
            toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: #selector(AddConsultationViewController.doneTimeStartPicker ))
           toolbar.setItems([doneButton], animated: false)
           toolbar.isUserInteractionEnabled = true
           TimeStartText.inputAccessoryView = toolbar
           TimeStartText.inputView = timeStartPicker
           
       }
       @objc func doneTimeStartPicker(){

         let formatter = DateFormatter()
         formatter.dateFormat = "hh:mm:ss"
           TimeStartText.text = formatter.string(from: timeStartPicker.date)
         self.view.endEditing(true)
       }
    func createTimeEndPicker(){
           timeEndPicker.datePickerMode = .time
           let toolbar = UIToolbar()
            toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: #selector(AddConsultationViewController.doneTimeEndPicker ))
           toolbar.setItems([doneButton], animated: false)
           toolbar.isUserInteractionEnabled = true
           TimeEndText.inputAccessoryView = toolbar
           TimeEndText.inputView = timeEndPicker
           
       }
       @objc func doneTimeEndPicker(){

         let formatter = DateFormatter()
         formatter.dateFormat = "hh:mm:ss"
           TimeEndText.text = formatter.string(from: timeEndPicker.date)
         self.view.endEditing(true)
       }
}
extension AddConsultationViewController: UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {
  
    
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return patients.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return patients[row].firstName
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedPatientId = patients[row]._id
        selectedPatientName = patients[row].firstName
        PatientText.text = selectedPatientName
    }
   
}
extension AddConsultationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}


