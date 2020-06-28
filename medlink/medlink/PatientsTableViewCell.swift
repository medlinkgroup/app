//
//  PatientsTableViewCell.swift
//  medlink
//
//  Created by Fabiana Montiel on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class PatientsTableViewCell: UITableViewCell {

    @IBOutlet var label_patient_name: UILabel!
    @IBOutlet var label_patient_first_name: UILabel!
    @IBOutlet var img_patient: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label_patient_name.text = label_patient_name.text?.uppercased()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
