//
//  ConsultationFactory.swift
//  medlink
//
//  Created by cylia boukhiba on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation


class ConsultationFactory {
    
    static func ConsultationWith(dictionary: [String: Any]) -> Consultation? {
//        print(dictionary["dates"])

        guard
            let _id = dictionary["_id"] as? String,
            let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
            let doctorUid = dictionary["doctorUid"] as? String,
            let patientUid = dictionary["patientUid"] as? String,
            let date = dictionary["date"] as? String,
            let appointmentTime = dictionary["appointmentTime"] as? String,
            let timeEnd = dictionary["timeEnd"] as? String
            else{
                return nil
        }

        return Consultation(_id: _id,
                     title: title,
                     description: description,
                     doctorUid: doctorUid,
                     patientUid: patientUid,
                     date: date,
                     appointmentTime: appointmentTime,
                     timeEnd: timeEnd
        );
    }
}
