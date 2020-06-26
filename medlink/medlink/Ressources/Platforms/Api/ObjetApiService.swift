//
//  ObjetApiService.swift
//  medlink
//
//  Created by cylia boukhiba on 26/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

class ObjetApiService: ObjetService {
    func getAll(completion: @escaping ([Objet]) -> Void) {
         URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/objets/")!) { (data, res, err) in
                   DispatchQueue.main.sync {
                       guard let d = data,
                           let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                           completion([])
                           return
                       }
                       completion(json.compactMap(ObjetFactory.ObjetWith(dictionary:)))
                       //print(json)
                   }
               }.resume()
    }
    
    func create(id: String, name: String, isAttributed: String, completion: @escaping (Bool) -> Void) {
           let body: [String: Any] = [
                   "name": name,
                   "isAttributed": isAttributed
               ]
             var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/objets/")!)
             request.httpMethod = "POST"
             request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
             
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                 completion(err == nil)
             }
             task.resume()

    }
    
    func delete(id: String, completion: @escaping (Bool) -> Void) {
         var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/objets/\(id)")!)
              request.httpMethod = "DELETE"
              request.setValue("application/json", forHTTPHeaderField: "Content-Type")
              let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                  completion(err == nil)
              }
              task.resume()
    }
    
  
    func edit(id: String, name: String, isAttributed: String, completion: @escaping (Bool) -> Void) {
        
         let body: [String: Any] = [
                                    "name": name,
                                    "isAttributed": isAttributed
                                ]
                   var request = URLRequest(url: URL(string: "https://medlinkapi.herokuapp.com/objets/\(id)")!)
                                 request.httpMethod = "PUT"
                                 request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                                 
                                 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                 let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                                     completion(err == nil)
                                 }
                                 task.resume()
               }
    }
    
    
   
  
   
   

