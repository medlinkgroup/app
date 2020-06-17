//
//  ConsultationService.swift
//  medlink
//
//  Created by cylia boukhiba on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
protocol ConsultationService{
    func getAll(completion: @escaping ([Consultation]) -> Void)
    
     func create(title: String, description: String, doctorUid: String, patientUid: String, date: String, appointmentTime: String,timeEnd: String,   completion: @escaping (Bool) -> Void)
     func delete(id: String, completion: @escaping (Bool) -> Void)
    
     func edit(  id: String ,title: String, description: String, doctorUid: String, patientUid: String, date: String, appointmentTime: String,timeEnd: String, completion: @escaping (Bool) -> Void)
    
     //  all reservation by id user
    

}
