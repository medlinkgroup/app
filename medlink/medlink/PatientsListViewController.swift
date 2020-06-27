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
    
    @IBOutlet weak var mapView: UIButton!
    @IBOutlet weak var btn_add_object: UIButton!
    
    public static let patientsTableViewCellId = "ptvc"
    
    var patientService: PatientService{
           //return PatientMockService()
        return PatientAPIService()
    }
   
    var patientDetail: Patient!
    var DoctorUID: String = ""
    var patientEdit: Patient!
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
                self.DoctorUID = document["uid"]! as! String
                   } else {
                       print("DOCTOR UID NOT FOUND : Document does not exist")
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
            print(". . . . . . . . \(self.DoctorUID)")
            self.patients = patients.filter({$0.doctorUid == self.DoctorUID})
            // filter just doctorId
            
            print(self.patients)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: PatientsListViewController.patientsTableViewCellId, for: indexPath) as! PatientsTableViewCell
           let patient = self.patients[indexPath.row]
        cell.label_patient_name.text = patient.lastName + " " + patient.firstName
        cell.label_patient_first_name.text = patient.place
        cell.img_patient.image = nil // restore default image
                     if let pictureURL = patient.photo {
                            DispatchQueue.global().async {
                                if let data = try? Data(contentsOf: pictureURL) {
                                    DispatchQueue.main.sync {
                                        cell.img_patient.image = UIImage(data: data)
                                    }
                                }
                            }
                        }
                       
                   
                   
           return cell
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        patients.count
    }
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           print("***************You tapped cell number \(indexPath.row).")
       }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
              let patient = patients[indexPath.row]
              self.patientDetail = patient
              let next = PatientDetailViewController().newInstance(detail: patientDetail)
              self.navigationController?.pushViewController(next, animated: true)
    
          
      }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
              let patient = self.patients[indexPath.row]
              if editingStyle == UITableViewCell.EditingStyle.delete {
            
              let refreshAlert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("confirm_delete", comment: ""), preferredStyle: UIAlertController.Style.alert)
              refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in do {
                       
                       self.patientService.delete( id: patient._id){
                                                    (success) in print(success)
                                                      //self.events.remove(at: indexPath.row)
                                                      //tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                          self.viewDidAppear(true)
                                                }
                       }
                       
                      }))
             
              refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler:nil ))
                   self.present(refreshAlert, animated: true, completion: nil)
             }
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
            let closeAction = UIContextualAction(style: .normal, title:  NSLocalizedString("modify", comment: ""), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let patient = self.patients[indexPath.row]
            self.patientEdit = patient
                
            let next = EditPatientViewController().newInstance(detail: self.patientEdit)
                // self.navigationController?.pushViewController(next, animated: true)
                 //let editEventViewController = EventsEditViewController()
                self.navigationController?.pushViewController(next, animated: true)
             })
             closeAction.image = UIImage(named: NSLocalizedString("update", comment: ""))
             closeAction.backgroundColor = .lightGray
     
             return UISwipeActionsConfiguration(actions: [closeAction])
     
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
    
    @IBAction func map_view(_ sender: Any) {
        let next = PatientsMapViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }

    @IBAction func btn_add_object(_ sender: Any) {
        self.navigationController?.pushViewController(AddObjetViewController(),animated:true)
    }
    
   
    

}
