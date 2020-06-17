//
//  PatientsListViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class PatientsListViewController: UIViewController {

    @IBOutlet weak var label_patients: UILabel!
    @IBOutlet weak var label_my_patients: UILabel!
    @IBOutlet weak var tableview_list_patients: UITableView!
    
    public static let patientsTableViewCellId = "ptvc"
    
    var patients: [Patient] = [] {
        didSet {
            self.tableview_list_patients.reloadData()
        }
    }
    var patientService: PatientService{
        return PatientMockService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.patientService.getAll{(patients)in
            self.patients = patients
            //self.sortData()
            self.tableview_list_patients.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthCheck()
        
        // Do any additional setup after loading the view.
    }
    
    private func AuthCheck(){

       if (Auth.auth().currentUser?.uid) == nil {
             self.navigationController?.setViewControllers([HomeViewController()], animated: false)
       }
           
    }

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PatientsListViewController.patientsTableViewCellId, for: indexPath) as! PatientsTableViewCell
        let patient = self.patients[indexPath.row]
        cell.label_patient_name.text = patient.lastName
        return cell
    }
    
    // when cell is selected
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patientDetail = PatientDetailViewController()
        //patientDetail.patientSelected = self.patients[indexPath.row]
        //self.navigationController?.pushViewController(patientDetail, animated: true)
    }
    */

}
