//
//  ConsultationsTableViewCell.swift
//  medlink
//
//  Created by Fabiana Montiel on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class ConsultationsTableViewCell: UITableViewCell {

    @IBOutlet var label_patient: UILabel!
    @IBOutlet var label_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}