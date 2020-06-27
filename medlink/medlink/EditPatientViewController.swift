//
//  EditPatientViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditPatientViewController: UIViewController {

    var editPatient : Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


  func newInstance(detail: Patient) -> EditPatientViewController {
            let view = EditPatientViewController()
            view.editPatient = detail
            return view
            
        }
     
     

}
