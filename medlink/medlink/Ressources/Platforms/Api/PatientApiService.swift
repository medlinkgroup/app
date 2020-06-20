//
//  PatientApiService.swift
//  medlink
//
//  Created by cylia boukhiba on 20/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

class PatientAPIService: PatientService {
    func getAll(completion: @escaping ([Patient]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/patients/")!) { (data, res, err) in
            DispatchQueue.main.sync {
                guard let d = data,
                    let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                    completion([])
                    return
                }
                completion(json.compactMap(PatientFactory.PatientWith(dictionary:)))
                print(json)
            }
        }.resume()
    }
    
    func delete(id: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/patients/\(id)")!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            completion(err == nil)
        }
        task.resume()
    }
   
    func create(id: String, firstName: String, lastName: String, phone: String, photo: URL,email: String, doctorUid: String, place: String, location: CLLocation, birthDate: String, completion: @escaping (Bool) -> Void) {
        let location = [
              "latitude": location.coordinate.latitude,
              "longitude": location.coordinate.longitude
          ]
          let body: [String: Any] = [
              "firstName": firstName,
              "lastName": lastName,
              "phone": phone,
              "photo": photo,
              "email": email,
              "doctorUid": doctorUid,
              "place": place,
              "location": location,
              "birthDate": birthDate
          ]
        var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/patients/")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            completion(err == nil)
        }
        task.resume()
        
    }
    
    func edit(id: String, firstName: String, lastName: String, phone: String, photo: URL, email: String, doctorUid: String, place: String, location: CLLocation, birthDate: String, completion: @escaping (Bool) -> Void) {
        let location = [
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude
        ]
        let body: [String: Any] = [
                         "firstName": firstName,
                         "lastName": lastName,
                         "phone": phone,
                         "photo": photo,
                         "email": email,
                         "doctorUid": doctorUid,
                         "place": place,
                         "location": location,
                         "birthDate": birthDate
                     ]
        var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/patients/\(id)")!)
                      request.httpMethod = "PUT"
                      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                      
                      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                      let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                          completion(err == nil)
                      }
                      task.resume()
    }
   
}
