//
//  EditPatientViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditPatientViewController: UIViewController {

    
    @IBOutlet var label_modify_patient: UILabel!
    @IBOutlet var label_name: UILabel!
    @IBOutlet var label_last_name: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_phone: UILabel!
    @IBOutlet var label_img: UILabel!
    @IBOutlet var label_adress: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var label_object_id: UILabel!
    @IBOutlet var btn_upload_image: UIButton!
    @IBOutlet var btn_modify_patient: UIButton!
    
    @IBOutlet var FirstNameText: UITextField!
    @IBOutlet var LastNameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PhoneText: UITextField!
    @IBOutlet var PlaceText: UITextField!
    @IBOutlet var ImageURLText: UITextField!
    @IBOutlet var DateText: UITextField!
    @IBOutlet var PhotoView: UIImageView!
    @IBOutlet var ObjectText: UITextField!
    
    
    
    
    var editPatient : Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label_modify_patient.text = NSLocalizedString("modify_patient", comment: "")
        label_name.text = NSLocalizedString("firstname", comment: "")
        label_last_name.text = NSLocalizedString("lastname", comment: "")
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_object_id.text = NSLocalizedString("objectid", comment: "")
        btn_modify_patient.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        btn_upload_image.setTitle(NSLocalizedString("upload", comment: ""), for: .normal)
        
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_phone.text = NSLocalizedString("phone_number", comment: "")
        label_img.text = NSLocalizedString("image", comment: "")
        label_adress.text = NSLocalizedString("adress", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        // Do any additional setup after loading the view.
    }


  func newInstance(detail: Patient) -> EditPatientViewController {
            let view = EditPatientViewController()
            view.editPatient = detail
            return view
            
        }
     
     

}
