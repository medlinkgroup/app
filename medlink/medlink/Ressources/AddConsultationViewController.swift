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

class AddConsultationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var label_add_consultation: UILabel!
    @IBOutlet var label_title_consultation: UILabel!
    @IBOutlet var label_patient_name_lastname: UILabel!
    @IBOutlet var label_date: UILabel!
    @IBOutlet var label_time_start: UILabel!
    @IBOutlet var label_time_end: UILabel!
    @IBOutlet var btn_add_consultation: UIButton!
    
    @IBOutlet var label_title_consultation_val: UILabel!
    @IBOutlet var label_patient_name_lastname_val: UILabel!
    @IBOutlet var label_date_val: UITextField!
    @IBOutlet var label_time_start_val: UILabel!
    @IBOutlet var label_time_end_val: UILabel!
    
    let datePicker = UIDatePicker()
    let timeStartPicker = UIDatePicker()
    let timeEndPicker = UIDatePicker()
    var UidDoc : String?
    let db = Firestore.firestore()
    
    var consultationService: ConsultationService{
        return ConsultationAPIService()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
                   // user connect
                   let docRef = db.collection("users").document(user.uid)
                   
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
        
        self.label_title_consultation.delegate = self
        self.label_patient_name_lastname_val.delegate = self
             
        btn_add_consultation.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        label_add_consultation.text = NSLocalizedString("add_consultation", comment: "")
        label_title_consultation.text = NSLocalizedString("title_consultation", comment: "")
        label_patient_name_lastname.text = NSLocalizedString("patient_name", comment: "")
        label_date.text = NSLocalizedString("date", comment: "")
        label_time_start.text = NSLocalizedString("time_start", comment: "")
        label_time_end.text = NSLocalizedString("time_end", comment: "")

        // Do any additional setup after loading the view.
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
