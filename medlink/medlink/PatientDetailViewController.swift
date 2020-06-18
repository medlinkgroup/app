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
        
        
        
        
        // Do any additional setup after loading the view.
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
