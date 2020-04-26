//
//  HomeViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 17/03/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login_Btn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    func valedateFields() -> String? {
        let email = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
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

    @IBAction func signUpBtn(_ sender: Any) {
        self.navigationController?.pushViewController(HomeSignUpViewController(), animated: true)
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        let error = valedateFields()
               if error != nil {
                      showError(error!)
               }else {
                   // create cleaned textfield
                   let email = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   // connection
                   Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                       if error != nil {
                           self.showError("Mot de passe incorrect")
                       } else {
                           self.navigationController?.setViewControllers([DocProfileListViewController()], animated: true)
                       }
                   })
               }
     
    }
    

}
