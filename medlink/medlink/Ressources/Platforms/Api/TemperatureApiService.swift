//
//  TemperatureApiService.swift
//  medlink
//
//  Created by Fabiana Montiel on 21/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import Alamofire
class TemperatureAPIService: TemperatureService {
    
   
    
    func getAll(completion: @escaping ([Temperature]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/temperatures/")!) { (data, res, err) in
            DispatchQueue.main.sync {
                guard let d = data,
                    let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                    completion([])
                    return
                }
                completion(json.compactMap(TemperatureFactory.TemperatureWith(dictionary:)))
                //print(json)
            }
        }.resume()
    }

}
      
   
    
    
   



