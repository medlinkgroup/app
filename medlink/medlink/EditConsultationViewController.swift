//
//  EditConsultationViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditConsultationViewController: UIViewController {

    var editConsultation: Consultation!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    func newInstance(detail: Consultation) -> EditConsultationViewController {
           let view = EditConsultationViewController()
           view.editConsultation = detail
           return view
           
       }
    
    

   

}
