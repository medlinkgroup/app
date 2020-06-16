//
//  ConsultationUtils.swift
//  medlink
//
//  Created by Fabiana Montiel on 15/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

class ConsultationUtils {

    static func map(item: [String:Any]) -> Consultation? {
        guard
            let id = item["id"] as? String,
            let title = item["title"] as? String,
            let description = item["description"] as? String,
            let doctor_id = item["doctor_uid"] as? String,
            let patient_id = item["patient_uid"] as? String,
            let date = item["date"] as? String,
            let time_start = item["timeStart"] as? String,
            let time_end = item["timeEnd"] as? String
        else {
            return nil
        }
        return Consultation(id: id, title: title, description: description, doctor_uid: doctor_id, patient_uid: patient_id, date: date, time_start: time_start, time_end: time_end)
    }
    /*
    static func filterByUser(consultations: [Consultation]) -> [Consultation] {
        return consultations.filter {
            //$0.user.id == UserUtils.user.id
            $0.doctor_uid == UserUtils.user.id
        }
    }
     */
}
