//
//  DoctorApiService.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

class DoctorApiService: DoctorService {
  
    
   
    func getAll(completion: @escaping ([Doctor]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/doctors")!) { (data, res, err) in
            DispatchQueue.main.sync {
                guard let d = data,
                    let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                    completion([])
                    return
                }
                completion(json.compactMap(DoctorFactory.DoctorWith(dictionary:)))
                print(json)
            }
        }.resume()
    }
    
    
}

