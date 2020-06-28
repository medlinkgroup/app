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
    
    func getAll(completion: @escaping ([Accelerometer]) -> Void) {
        
       URLSession.shared.dataTask(with: URL(string: "https://medlinkapi.herokuapp.com/accelerometres/")!) { (data, res, err) in
           DispatchQueue.main.sync {
               guard let d = data,
                   let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [[String: Any]] else {
                   completion([])
                   return
               }
               completion(json.compactMap(AccelerometerFactory.AccelerometerWith(dictionary:)))
               //print(json)
           }
       }.resume()
       
    }
    
    

}
