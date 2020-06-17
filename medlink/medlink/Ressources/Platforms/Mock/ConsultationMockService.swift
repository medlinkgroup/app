//
//  ConsultationMockService.swift
//  medlink
//
//  Created by cylia boukhiba on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

class ConsultationMockService: ConsultationService {
     
    func create(title: String, description: String, doctorUid: String, patientUid: String, date: String, appointmentTime: String,timeEnd: String,  completion: @escaping (Bool) -> Void) {
         completion(false)
    }
    
    func edit( id: String ,title: String, description: String, doctorUid: String, patientUid: String, date: String, appointmentTime: String,timeEnd: String, completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    
    func getAll(completion: @escaping ([Consultation]) -> Void) {
          completion(self.consultations)
      }
      
    
     func delete(id: String, completion: @escaping (Bool) -> Void) {
        completion(false)
      /*self.events.removeAll(where: { (r) -> Bool in
          
              return r._id == _id
          print(r._id)
          })*/
    }
    
    private var consultations: [Consultation] = [
        Consultation(_id: "1",
              title: "event1",
              description: "event1des",
              doctorUid: "event1 freetaxt",
              patientUid: "testtt",
              date: "2019-12-26T00:00:00.000Z",
              appointmentTime: "10:00:00",
              timeEnd: "10:00:00"
              ),
        Consultation(_id: "2",
              title: "event2",
        description: "event1des",
        doctorUid: "event1 freetaxt",
        patientUid: "cylia@gmail.com",
        date: "2019-12-26T00:00:00.000Z",
        appointmentTime: "10:00:00",
        timeEnd: "10:00:00"
        ),
        Consultation(_id: "3",
                     title: "event1",
                     description: "event1des",
                     doctorUid: "event1 freetaxt",
                     patientUid: "testtt",
                     date: "2021-12-26T00:00:00.000Z",
                     appointmentTime: "10:00:00",
                     timeEnd: "10:00:00"
                     ),
        
    ]
    
}
