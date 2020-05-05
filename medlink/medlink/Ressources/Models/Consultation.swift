//
//  Consultation.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

struct Consultation {
    
    var title: String
    var description: String
    var doctor_uid: String
    var patient_uid: String
    var date: String
    var time_start: String
    var time_end: String
    
    func dictionnary() -> [String : Any] {
        return [
            "title": self.title,
            "description": self.description,
            "medecinUid": self.patient_uid,
            "patientUid": self.date,
            "date": self.date,
            "timeStart": self.time_start,
            "timeEnd": self.time_end
        ]
    }
}
