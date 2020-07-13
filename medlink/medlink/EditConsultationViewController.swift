//
//  EditConsultationViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditConsultationViewController: UIViewController {
    
    @IBOutlet var label_edit_consultation: UILabel!
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var ObservationText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    @IBOutlet weak var TimeStartText: UITextField!
    
    @IBOutlet var btn_edit_consultation: UIButton!
    
    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_observation: UILabel!
    @IBOutlet var label_date: UILabel!
    @IBOutlet var label_time_start: UILabel!

    var id : String?
    var editConsultation: Consultation!
    let datePicker = UIDatePicker()
    let timeStartPicker = UIDatePicker()
    var consultationService: ConsultationService{
        return ConsultationAPIService()
    }
    override func viewDidLoad() {
       super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        label_edit_consultation.text = NSLocalizedString("edit_consultation", comment: "")
        label_title.text = NSLocalizedString("title_consultation", comment: "")
        label_observation.text = NSLocalizedString("observations", comment: "")
        label_date.text = NSLocalizedString("date", comment: "")
        label_time_start.text = NSLocalizedString("time_start", comment: "")
        btn_edit_consultation.setTitle(NSLocalizedString("modify", comment: ""), for: .normal)
        id = editConsultation._id
        loadData()
        createDatePicker()
        createTimeStartPicker()
        
        self.DateText.delegate = self
        self.TimeStartText.delegate = self
        
    }

    func newInstance(detail: Consultation) -> EditConsultationViewController {
           let view = EditConsultationViewController()
           view.editConsultation = detail
           return view
           
       }
    
    
    func loadData() {
         if (editConsultation != nil){
             
              
             self.TitleText.text = editConsultation.title
             self.ObservationText.text = editConsultation.description
             self.DateText.text = editConsultation.date
            self.TimeStartText.text = editConsultation.appointmentTime
           
         }
         
     }
    @IBAction func save_btn(_ sender: Any) {
        guard
               let id = id,
               let title = TitleText.text,
               let description = ObservationText.text,
               let date = DateText.text,
               let timeStart = TimeStartText.text,
            
               
                   id.count > 0,
                   title.count > 0,
                   description.count > 0,
                   date.count > 0,
                   timeStart.count > 0,
                   date.count > 0,
                   timeStart.count > 0
                   
               else {
                   
                   self.displayError(message: NSLocalizedString("missing_field", comment: ""))
                   return
               }
                  
                     //let email = emailTextField.text,
        self.consultationService.edit(id: id, title: title, description: description, doctorUid: editConsultation.doctorUid, patientUid: editConsultation.patientUid, date: date, appointmentTime: timeStart, timeEnd: editConsultation.timeEnd){
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
    
    func createTimeStartPicker(){
            timeStartPicker.datePickerMode = .time
            let toolbar = UIToolbar()
             toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: #selector(EditConsultationViewController.doneTimeStartPicker ))
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
    
      //// date
      func createDatePicker(){
          datePicker.datePickerMode = .date
          let toolbar = UIToolbar()
           toolbar.sizeToFit()
          let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: #selector(EditConsultationViewController.donedatePicker ))
          toolbar.setItems([doneButton], animated: false)
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
    }

extension EditConsultationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
    
   


