//
//  DocDashboardListViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

class DocDashboardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var consultationsTableView: UITableView!
    @IBOutlet var patientsTableView: UITableView!
    
    @IBOutlet var btn_profile: UIImageView!
    @IBOutlet var btn_add_consultation: UIImageView!
    @IBOutlet var btn_add_patient: UIImageView!
    @IBOutlet var label_consultations: UILabel!
    @IBOutlet var label_patients: UILabel!
    @IBOutlet var label_dashboard: UILabel!
    @IBOutlet var label_profile: UILabel!
    @IBOutlet var label_add_consultation: UILabel!
    @IBOutlet var label_add_patient: UILabel!
    
    // API : https://medlinkapi.herokuapp.com/
    
    public static let consultationsTableViewCellId = "ctvc"
    public static let patientsTableViewCellId = "ptvc"
    
    var consultations: [Consultation] = [] {
        didSet {
            self.consultationsTableView.reloadData()
        }
    }
    
    var patients: [Patient] = [] {
        didSet {
            self.patientsTableView.reloadData()
        }
    }
    
    //var filmCall: FilmCall {
    //    return FilmCallAPI()
    //}
    /*
    var consultationService: ConsultationCall {
        return BilletCallAPI()
    }
    var reservations: [Billet] = [] {
        didSet {
            self.reservationsList.reloadData()
        }
    }*/
    
    
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
        
        
        //self.consultationsTableView.rowHeight = 120
        self.consultationsTableView.backgroundColor = UIColor.clear
        self.consultationsTableView.register(UINib(nibName: "ConsultationsTableViewCell", bundle: nil), forCellReuseIdentifier: DocDashboardListViewController.consultationsTableViewCellId)
        self.consultationsTableView.dataSource = self
        self.consultationsTableView.delegate = self
        
        //self.patientsTableView.rowHeight = 120
        self.patientsTableView.backgroundColor = UIColor.clear
        self.patientsTableView.register(UINib(nibName: "PatientsTableViewCell", bundle: nil), forCellReuseIdentifier: DocDashboardListViewController.patientsTableViewCellId)
        self.patientsTableView.dataSource = self
        self.patientsTableView.delegate = self
        
        
        
        self.ConsultationService.all { (consultations) in
            self.consultations = consultations
            print(self.consultations)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    var ConsultationService: ConsultationCall {
        //return ConsultationsMockService()
        return ConsultationCallAPI()
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


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.consultations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocDashboardListViewController.consultationsTableViewCellId, for: indexPath) as! ConsultationsTableViewCell
        let consultation = self.consultations[indexPath.row]
        cell.label_patient.text = consultation.description //??????
        //cell.dateLabel.text = DateUtils.toString(date: billet.date)
        //cell.timeLabel.text = billet.time
        return cell
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
