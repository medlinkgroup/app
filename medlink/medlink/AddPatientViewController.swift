//
//  AddPatientViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class AddPatientViewController: UIViewController {

    @IBOutlet var label_add_patient: UILabel!
    @IBOutlet var label_name: UILabel!
    @IBOutlet weak var label_lastname: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_object_id: UILabel!
    @IBOutlet var btn_add_patient: UIButton!
    @IBOutlet weak var btn_upload_image: UIButton!
    @IBOutlet weak var FirstNameText: UITextField!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PhoneText: UITextField!
    @IBOutlet weak var ImageURLText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        /*label_add_patient.text = NSLocalizedString("add_patient", comment: "")
        label_name.text = NSLocalizedString("firstname", comment: "")
        label_lastname.text = NSLocalizedString("lastname", comment: "")
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_object_id.text = NSLocalizedString("objectid", comment: "")
        btn_add_patient.setTitle(NSLocalizedString("add", comment: ""), for: .normal)*/
        // Do any additional setup after loading the view.
    }

}
