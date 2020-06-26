//
//  AccelerometerApiService.swift
//  medlink
//
//  Created by Fabiana Montiel on 21/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import Alamofire

class AccelerometerAPIService: AccelerometerService {
    
    private let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func getAll(completion: @escaping ([Accelerometer]) -> Void) {
        
        var accelerometerResponse:[Accelerometer] = []
        
         AF.request("https://medlinkapi.herokuapp.com/accelerometres/", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
             
             guard let json_response = response.value as? [String: Any],
                     let accelerometers = json_response["accelerometres"] as? [[String: Any]] else{
                         return
                     }
             
             for t in accelerometers {
                 guard let _id = t["_id"] as? String,
                    let deviceID = t["deviceID"] as? String,
                    let date = t["date"] as? String,
                    let accelerometerXValues = t["accelerometerXValues"] as? [Double],
                    let accelerometerYValues = t["accelerometerYValues"] as? [Double],
                    let accelerometerZValues = t["accelerometerZValues"] as? [Double]
                    else {
                        print("error on /accelerometers")
                        return
                 }
                accelerometerResponse.append(Accelerometer(_id: _id,
                                     deviceID : deviceID,
                                     date : date,
                                     accelerometerXValues : accelerometerXValues,
                                     accelerometerYValues : accelerometerYValues,
                                     accelerometerZValues : accelerometerZValues
                ))
                 
             }
             
             completion(accelerometerResponse)
         }
        
        /*URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/temperatures/")!) { (data, res, err) in
            DispatchQueue.main.sync {
                guard let d = data,
                    let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                    completion([])
                    return
                }
                completion(json.compactMap(PatientFactory.PatientWith(dictionary:)))
                //print(json)
            }
        }.resume()
         */
    }
    
    func delete(_id: String, completion: @escaping (Bool) -> Void) {
        /*var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/patients/\(id)")!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            completion(err == nil)
        }
        task.resume()
         */
    }
   
    func create(_id: String, deviceID: String, date: String, accelerometerXValues: [Double], accelerometerYValues: [Double], accelerometerZValues: [Double], completion: @escaping (Bool) -> Void) {
        /*let location = [
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
        */
    }
    
    func edit(_id: String, deviceID: String, date: String, accelerometerXValues: [Double], accelerometerYValues: [Double], accelerometerZValues: [Double], completion: @escaping (Bool) -> Void) {
        /*let location = [
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
    }*/
   
    }

}
