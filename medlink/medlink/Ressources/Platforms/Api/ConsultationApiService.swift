//
//  ConsultationApiService.swift
//  medlink
//
//  Created by cylia boukhiba on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

class ConsultationAPIService: ConsultationService {
 
      
       
      
       //  all reservation by id user
      
    
    func edit( id: String ,title: String, description: String, doctorUid: String, patientUid: String, date: String, appointmentTime: String,timeEnd: String, completion: @escaping (Bool) -> Void) {
            
          let body: [String: Any] = [
                  "title": title,
                  "description": description,
                  "doctorUid": doctorUid,
                  "patientUid": patientUid,
                  "date": date,
                  "appointmentTime": appointmentTime,
                  "timeEnd": timeEnd
              ]
        var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/consultations/\(id)")!)
               request.httpMethod = "PUT"
               request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
               
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                   completion(err == nil)
               }
               task.resume()
    }
    
    func delete( id: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/consultations/\(id)")!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            completion(err == nil)
        }
        task.resume()
    }
      
    func create(title: String, description: String, doctorUid: String, patientUid: String, date: String, appointmentTime: String,timeEnd: String,  completion: @escaping (Bool) -> Void) {
        
        let body: [String: Any] = [
            "title": title,
            "description": description,
            "doctorUid": doctorUid,
            "patientUid": patientUid,
            "date": date,
            "appointmentTime": appointmentTime,
            "timeEnd": timeEnd
        ]
      
        var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/consultations/")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            completion(err == nil)
        }
        task.resume()
        
    }
    
    
    func getAll(completion: @escaping ([Consultation]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/consultations/")!) { (data, res, err) in
            DispatchQueue.main.sync {
                guard let d = data,
                    let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                    completion([])
                    return
                }
                completion(json.compactMap(ConsultationFactory.ConsultationWith(dictionary:)))
                print(json)
            }
        }.resume()
    }
    
   
}


