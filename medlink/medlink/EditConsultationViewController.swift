//
//  EditConsultationViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditConsultationViewController: UIViewController {
    
    @IBOutlet var label_edit_consultation: UILabel!
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var ObservationText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    @IBOutlet weak var TimeStartText: UITextField!
    
    @IBOutlet var btn_edit_consultation: UIButton!
    
    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_observation: UILabel!
    @IBOutlet var label_date: UILabel!
    @IBOutlet var label_time_start: UILabel!

    var editConsultation: Consultation!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        label_edit_consultation.text = NSLocalizedString("edit_consultation", comment: "")
        label_title.text = NSLocalizedString("title_consultation", comment: "")
        label_observation.text = NSLocalizedString("observations", comment: "")
        label_date.text = NSLocalizedString("date", comment: "")
        label_time_start.text = NSLocalizedString("time_start", comment: "")
        btn_edit_consultation.setTitle(NSLocalizedString("modify", comment: ""), for: .normal)
    }

    func newInstance(detail: Consultation) -> EditConsultationViewController {
           let view = EditConsultationViewController()
           view.editConsultation = detail
           return view
           
       }
    
    

   

}
