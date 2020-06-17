
//
//  DocDashboardListViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DocDashboardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var consultationsTableView: UITableView!
    @IBOutlet var label_consultations: UILabel!
    @IBOutlet var label_dashboard: UILabel!
    
    
    // API : https://medlinkapi.herokuapp.com/
    
    public static let consultationsTableViewCellId = "ctvc"
    
    var consultations: [Consultation] = [] {
        didSet {
            self.consultationsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //checkIfUserIsSignedIn()

        
        
        label_consultations.text = NSLocalizedString("list_consultations", comment: "")
        label_dashboard.text = NSLocalizedString("dashboard", comment: "")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let tap_profile = UITapGestureRecognizer(target: self, action: #selector(DocDashboardListViewController.goToProfile))
        //btn_profile.addGestureRecognizer(tap_profile)
        //btn_profile.isUserInteractionEnabled = true
        
        let tap_add_consultation = UITapGestureRecognizer(target: self, action: #selector(DocDashboardListViewController.goToAddConsultation))
        //btn_add_consultation.addGestureRecognizer(tap_add_consultation)
        //btn_add_consultation.isUserInteractionEnabled = true
        
       
        
        
        //self.consultationsTableView.rowHeight = 120
        self.consultationsTableView.backgroundColor = UIColor.clear
        self.consultationsTableView.register(UINib(nibName: "ConsultationsTableViewCell", bundle: nil), forCellReuseIdentifier: DocDashboardListViewController.consultationsTableViewCellId)
        self.consultationsTableView.dataSource = self
        self.consultationsTableView.delegate = self
        
        
        
        
        
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
