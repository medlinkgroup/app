//
//  PatientDetailViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class PatientDetailViewController: UIViewController {

    @IBOutlet var label_patient_name: UILabel!
    @IBOutlet var label_patient_firstname: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_phone: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var label_adress: UILabel!
    @IBOutlet var label_location: UILabel!
    @IBOutlet var img_photo_patient: UIImageView!
    @IBOutlet var label_birthdate_val: UILabel!
    @IBOutlet var label_phone_val: UILabel!
    @IBOutlet var label_email_val: UILabel!
    @IBOutlet var label_adress_val: UILabel!
    @IBOutlet var label_location_val: UILabel!
    
    
    var patientDetail: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //btn_add_consultation.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        //label_add_consultation.text = NSLocalizedString("add_consultation", comment: "")
        label_patient_name.text = label_patient_name.text?.uppercased()
        
        //label_patient_name.text = NSLocalizedString("", comment: "")
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_phone.text = NSLocalizedString("phone_number", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        label_adress.text = NSLocalizedString("adress", comment: "")
        label_location.text = NSLocalizedString("location", comment: "")
        
        label_birthdate_val.textAlignment = .natural
        label_phone_val.textAlignment = .natural
        label_email_val.textAlignment = .natural
        label_adress_val.textAlignment = .natural
        label_location_val.textAlignment = .natural
        
        loadDataDetails()
        
        
        // Do any additional setup after loading the view.
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
