//
//  HomeSignUpViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 23/03/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeSignUpViewController: UIViewController {
    
    @IBOutlet var label_sign_up: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet var label_sign_up_title: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var label_password: UILabel!
    @IBOutlet var label_first_name: UILabel!
    @IBOutlet var label_last_name: UILabel!
    @IBOutlet var btn_sign_up: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //errorLabel.alpha = 0
        
        label_sign_up_title.text = NSLocalizedString("sign_up_title", comment: "")
        label_last_name.text = NSLocalizedString("lastname", comment: "")
        label_first_name.text = NSLocalizedString("firstname", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        label_password.text = NSLocalizedString("password", comment: "")
        btn_sign_up.setTitle(NSLocalizedString("btn_signup", comment: ""), for: .normal)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func valedateFields() -> String? {
              let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              // check that all fields are filled in
              if email == "" && password == "" {
                      return "Erreur : les champs ne sont pas complets"
              }
              return nil
    }
    
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

    func transitionToHomeEvent() {
        self.dismiss(animated: true, completion: nil)
      
             // go to home
             self.navigationController?.setViewControllers([HomeViewController()], animated: true)
             let alertController = UIAlertController(title: nil, message: "User was sucessfully created", preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
             self.present(alertController, animated: true, completion: nil)
    
             
       
         }
    
    
    @IBAction func sign_up(_ sender: Any) {
        let error = valedateFields()
        if (error != nil){
            showError(error!)
        }else {
           
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if error != nil {
                    self.showError("Cette email existe")
                    return
                }
                guard let userID = Auth.auth().currentUser?.uid else { return }
                
                let db = Firestore.firestore()
                
                db.collection("users").document(userID).setData([
                            
                            "email": email,
                            "uid": userID,
                            "fistname": firstname,
                            "lastname": lastname,
                          
                ]) { (err) in
                        if err != nil {
                            self.showError("error saveing data user")
                        } else {
                           
                            print("Document added with ID: \(userID)")
                            self.transitionToHomeEvent()
                        }
                    }
                
            }
        }
    }
    
    /*@IBAction func signUpBtn(_ sender: Any) {
        let error = valedateFields()
        if (error != nil){
            showError(error!)
        }else {
           
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if error != nil {
                    self.showError("Cette email existe")
                    return
                }
                guard let userID = Auth.auth().currentUser?.uid else { return }
                
                let db = Firestore.firestore()
                
                db.collection("users").document(userID).setData([
                            
                            "email": email,
                            "uid": userID,
                            "fistname": firstname,
                            "lastname": lastname,
                          
                ]) { (err) in
                        if err != nil {
                            self.showError("error saveing data user")
                        } else {
                           
                            print("Document added with ID: \(userID)")
                            self.transitionToHomeEvent()
                        }
                    }
                
            }
        }
        
    }*/
    
    
    
 

}
