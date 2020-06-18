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

class PatientsListViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{

    
    @IBOutlet var label_patients: UILabel!
    @IBOutlet var label_my_patients: UILabel!
    @IBOutlet weak var tableview_list_patients: UITableView!
    @IBOutlet var img_add_patient: UIImageView!
    @IBOutlet var img_add_consultation: UIImageView!
    
    public static let patientsTableViewCellId = "ptvc"
    
    var patientService: PatientService{
           return PatientMockService()
       }
   
   
    var DoctorUID: String?
    
    var patients: [Patient] = [] {
           didSet {
               self.tableview_list_patients.reloadData()
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        label_patients.text = NSLocalizedString("patients", comment: "")
        label_my_patients.text = NSLocalizedString("list_patients", comment: "")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.action_add_patient(gesture:)))

        // add it to the image view;
        img_add_patient.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        img_add_patient.isUserInteractionEnabled = true
        
        
        // create tap gesture recognizer
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.action_add_consultation(gesture:)))

        // add it to the image view;
        img_add_consultation.addGestureRecognizer(tapGesture2)
        // make sure imageView can be interacted with by user
        img_add_consultation.isUserInteractionEnabled = true
        
        
        
        
        self.tableview_list_patients.rowHeight = 120
        self.tableview_list_patients.register(UINib(nibName: "PatientsTableViewCell", bundle: nil), forCellReuseIdentifier: PatientsListViewController.patientsTableViewCellId)
        self.tableview_list_patients.dataSource = self
        self.tableview_list_patients.delegate = self
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser{
            let docRef = db.collection("users").document(user.uid)
            self.DoctorUID = user.uid
            print(docRef)
        
           docRef.getDocument { (document, error) in
                
            
              if let document = document, document.exists {
              
                   print(document.data()!)
                   self.DoctorUID = document["uid"] as? String
                   } else {
                       print("Document does not exist")
                   }
               }
            } else {
                //fatalError(" Erreur : aucun user connect")
                print("no user connected")
            }
        
           
           // Do any additional setup after loading the view.
       }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.patientService.getAll { (patients) in
            print(patients)
             
            self.patients = patients.filter({$0.doctorUid == self.DoctorUID})
            // filter just doctorId
            
            print(self.patients)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: PatientsListViewController.patientsTableViewCellId, for: indexPath) as! PatientsTableViewCell
           let patient = self.patients[indexPath.row]
           cell.label_patient_name.text = patient.lastName
           return cell
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        patients.count
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           print("You tapped cell number \(indexPath.row).")
       }
   
    
    
    @objc func action_add_patient(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.navigationController?.pushViewController(AddPatientViewController(),animated:true)
            //Here you can initiate your new ViewController

        }
    }
    
    @objc func action_add_consultation(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.navigationController?.pushViewController(AddConsultationViewController(),animated:true)
            //Here you can initiate your new ViewController

        }
    }
    
    
    // when cell is selected
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let patientDetail = PatientDetailViewController()
        //patientDetail.patientSelected = self.patients[indexPath.row]
        //self.navigationController?.pushViewController(patientDetail, animated: true)
        self.navigationController?.pushViewController(PatientDetailViewController(),animated:true)
    }
 */
    

}
