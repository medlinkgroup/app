//
//  DocAccountViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DocAccountViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var specialityTextField: UITextField!
    
    @IBOutlet var label_my_account: UILabel!
    @IBOutlet var label_first_name: UILabel!
    @IBOutlet var label_last_name: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var label_phone_number: UILabel!
    @IBOutlet var label_specialty: UILabel!
    @IBOutlet var btn_save: UIButton!
    @IBOutlet var btn_sign_out: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label_my_account.text = NSLocalizedString("my_account", comment: "")
        label_first_name.text = NSLocalizedString("firstname", comment: "")
        label_last_name.text = NSLocalizedString("lastname", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        label_phone_number.text = NSLocalizedString("phone_number", comment: "")
        label_specialty.text = NSLocalizedString("field", comment: "")
        btn_save.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        btn_sign_out.setTitle(NSLocalizedString("logout", comment: ""), for: .normal)
        
        let db = Firestore.firestore()
          
              if let user = Auth.auth().currentUser {
                  // user connect
                  let docRef = db.collection("users").document(user.uid)
                  
                 docRef.getDocument { (document, error) in
                 if let document = document, document.exists {
                      self.firstNameTextField.text = document["firstname"] as? String
                      self.lastNameTextField.text = document["lastname"] as? String
                      self.emailTextField.text = document["email"] as? String
                      self.phoneNumberTextField.text = document["phone"] as? String
                      self.specialityTextField.text = document["speciality"] as? String
                     } else {
                         print("Document does not exist")
                     }
                 }
              } else {
                  //fatalError(" Erreur : aucun user connect")
                if (Auth.auth().currentUser?.uid) == nil {
                                   self.navigationController?.setViewControllers([HomeViewController()], animated: false)
                   // self.navigationController?.setNavigationBarHidden(true, animated: true)
                    
                             }
                
              }

        // Do any additional setup after loading the view.
    }
 
 
    @IBAction func SignOut(_ sender: Any) {
        try! Auth.auth().signOut()
       
               self.navigationController?.setViewControllers([HomeViewController()], animated: true)
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
                
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let speciality = specialityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            guard let userID = Auth.auth().currentUser?.uid else { return }
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userID)

            // Set the "capital" field of the city 'DC'
            userRef.updateData([
                "email": email,
                "firstname": firstname,
                "lastname": lastname,
                "phone": phone,
                "speciality": speciality,
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }

    }
        


}
    

