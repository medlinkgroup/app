//
//  DocDashboardListViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

class DocDashboardListViewController: UIViewController {

    @IBOutlet var btn_profile: UIImageView!
    @IBOutlet var btn_add_consultation: UIImageView!
    @IBOutlet var btn_add_patient: UIImageView!
    @IBOutlet var label_consultations: UILabel!
    @IBOutlet var label_patients: UILabel!
    @IBOutlet var label_dashboard: UILabel!
    @IBOutlet var label_profile: UILabel!
    @IBOutlet var label_add_consultation: UILabel!
    @IBOutlet var label_add_patient: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //checkIfUserIsSignedIn()

        
        
        label_consultations.text = NSLocalizedString("list_consultations", comment: "")
        label_patients.text = NSLocalizedString("list_patients", comment: "")
        label_profile.text = NSLocalizedString("view_profile", comment: "")
        label_add_consultation.text = NSLocalizedString("add_consultation", comment: "")
        label_add_patient.text = NSLocalizedString("add_patient", comment: "")
        label_dashboard.text = NSLocalizedString("dashboard", comment: "")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let tap_profile = UITapGestureRecognizer(target: self, action: #selector(DocDashboardListViewController.goToProfile))
        btn_profile.addGestureRecognizer(tap_profile)
        btn_profile.isUserInteractionEnabled = true
        
        let tap_add_consultation = UITapGestureRecognizer(target: self, action: #selector(DocDashboardListViewController.goToAddConsultation))
        btn_add_consultation.addGestureRecognizer(tap_add_consultation)
        btn_add_consultation.isUserInteractionEnabled = true
        
        let tap_add_patient = UITapGestureRecognizer(target: self, action: #selector(DocDashboardListViewController.goToAddPatient))
        btn_add_patient.addGestureRecognizer(tap_add_patient)
        btn_add_patient.isUserInteractionEnabled = true
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func goToProfile()
    {
        print("Tapped on Image profile")
    }
    @objc func goToAddConsultation()
    {
        print("Tapped on Image consultation")
    }
    @objc func goToAddPatient()
    {
        print("Tapped on Image patient")
    }
    
    private func checkIfUserIsSignedIn() {
    
        let db = Firestore.firestore()

        if Auth.auth().currentUser  == nil {
         //Check si un user est connecté
         self.navigationController?.pushViewController(HomeViewController(), animated: false)
        }
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
