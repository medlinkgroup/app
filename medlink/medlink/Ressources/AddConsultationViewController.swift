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
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var PatientText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    @IBOutlet weak var TimeStartText: UITextField!
    @IBOutlet weak var TimeEndText: UITextField!
    
    @IBOutlet var btn_add_consultation: UIButton!
    
   
    
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
        
      
       

        
    }


 

}
