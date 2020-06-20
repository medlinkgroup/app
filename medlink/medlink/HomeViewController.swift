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
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet var label_login_title: UILabel!
    @IBOutlet var label_username: UILabel!
    @IBOutlet var label_password: UILabel!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        
        login_Btn.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
        signUpBtn.setTitle(NSLocalizedString("signup", comment: ""), for: .normal)
        signUpBtn.titleLabel?.textAlignment = NSTextAlignment.center
        label_login_title.text = NSLocalizedString("login", comment: "")
        label_username.text = NSLocalizedString("email", comment: "")
        label_password.text = NSLocalizedString("password", comment: "")
        
        //AuthCheck()
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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

    private func AuthCheck(){

           if (Auth.auth().currentUser?.uid) != nil {
                 self.navigationController?.setViewControllers([DocDashboardListViewController()], animated: false)
           }
           
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
                           self.navigationController?.setViewControllers([NavBarController()], animated: true)
                       }
                   })
               }
     
    }
    
    
    

}
