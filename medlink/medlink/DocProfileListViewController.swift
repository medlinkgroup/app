//
//  DocProfileListViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 23/03/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

class DocProfileListViewController: UIViewController {
    
    @IBOutlet var btn_profile: UIButton!
    @IBOutlet var btn_add_consultation: UIButton!
    @IBOutlet var btn_add_patient: UIButton!
    @IBOutlet var label_consultations: UILabel!
    @IBOutlet var label_patients: UILabel!
    @IBOutlet var label_dashboard: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkIfUserIsSignedIn()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        label_consultations.text = NSLocalizedString("list_consultations", comment: "")
        label_patients.text = NSLocalizedString("list_patients", comment: "")
        btn_profile.titleLabel?.textAlignment = .center
        btn_profile.setTitle(NSLocalizedString("view_profile", comment: ""), for: .normal)
        
        btn_add_consultation.titleLabel?.textAlignment = .center
        btn_add_consultation.setTitle(NSLocalizedString("add_consultation", comment: ""), for: .normal)
        
        btn_add_patient.titleLabel?.textAlignment = .center
        btn_add_patient.setTitle(NSLocalizedString("add_patient", comment: ""), for: .normal)
              
        label_dashboard.text = NSLocalizedString("dashboard", comment: "")
         
        
        // Do any additional setup after loading the view.
    }

    private func checkIfUserIsSignedIn() {
    
             let db = Firestore.firestore()

             if Auth.auth().currentUser  == nil {
                 //Check si un user est connecté
                 self.navigationController?.pushViewController(HomeViewController(), animated: false)
             }
     }

}
