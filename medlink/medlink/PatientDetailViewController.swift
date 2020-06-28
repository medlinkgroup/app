//
//  PatientDetailViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class PatientDetailViewController: UIViewController {

    @IBOutlet var label_patient_name: UILabel!
    @IBOutlet var label_patient_firstname: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_phone: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var label_adress: UILabel!
    @IBOutlet var img_photo_patient: UIImageView!
    @IBOutlet var label_birthdate_val: UILabel!
    @IBOutlet var label_phone_val: UILabel!
    @IBOutlet var label_email_val: UILabel!
    @IBOutlet var label_adress_val: UILabel!
    @IBOutlet var label_objectid: UILabel!
    @IBOutlet var label_objectid_val: UILabel!
    
    var patientDetail: Patient!
    
    var objects = [Objet] ()
    var selectedObjectId: String?
    var selectedObjectName: String?
    var objet : Objet!
    var id : String?
    var doctorUID : String?
    let db = Firestore.firestore()
    var objetService: ObjetService{
        return ObjetApiService()
    }
    var patientService: PatientService{
        return PatientAPIService()
        //return PatientMockService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label_objectid_val.text = "N/A"
        label_patient_name.text = label_patient_name.text?.uppercased()
        
        //label_patient_name.text = NSLocalizedString("", comment: "")
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_phone.text = NSLocalizedString("phone_number", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        label_adress.text = NSLocalizedString("adress", comment: "")
        label_objectid.text = NSLocalizedString("objectid", comment: "")
        
        label_birthdate_val.textAlignment = .natural
        label_phone_val.textAlignment = .natural
        label_email_val.textAlignment = .natural
        label_adress_val.textAlignment = .natural
        label_objectid_val.textAlignment = .natural
        
        loadDataDetails()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        self.objetService.getAll { (objets) in
            print(objets)
            self.objet = objets.first(where: { (objet) -> Bool in
                objet._id == self.patientDetail.objetUid
            })
                
            if (self.objet != nil){
                self.label_objectid_val.text = self.objet.name
            }
            self.objetService.getAll { (objects) in
                print(objects)
                self.objects = objects.filter({$0.isAttributed == false})
                // filter just doctorId
                print(self.objects)
            }
        }
    }


    func newInstance(detail: Patient) -> PatientDetailViewController {
        let view = PatientDetailViewController()
        view.patientDetail = detail
        return view
        
    }
    
    
    func loadDataDetails( ){
        // let db = Firestore.firestore()
        // let docRef = db.collection("users").document(eventDetail.creatorUid)
        /* docRef.getDocument { (document, error) in
             if let document = document, document.exists {
                 self.nameLabel.text = document["username"] as? String
             }
         }*/
        label_patient_name.text = patientDetail.lastName
        label_patient_name.text = label_patient_name.text?.uppercased()
        label_patient_firstname.text = patientDetail.firstName
        label_birthdate_val.text = patientDetail.birthDate
        let first10 = String((label_birthdate_val.text?.prefix(10))!)
        label_birthdate_val.text = first10
        label_phone_val.text = patientDetail.phone
        label_email_val.text = patientDetail.email
        label_adress_val.text = patientDetail.place
        //label_objectid_val.text = patientDetail.objetUid
        img_photo_patient.image = UIImage(named: "profile_default.png") // restore default image
        // label_location_val.text = patientDetail.location
        if let pictureURL = patientDetail.photo {
             DispatchQueue.global().async {
                if let data = try? Data(contentsOf: pictureURL) {DispatchQueue.main.sync {self.img_photo_patient.image = UIImage(data: data)}}
                print(self.patientDetail!)
             }
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
