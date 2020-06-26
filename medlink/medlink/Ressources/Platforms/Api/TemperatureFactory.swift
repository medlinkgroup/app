//
//  TemperatureFactory.swift
//  medlink
//
//  Created by Fabiana Montiel on 21/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

class TemperatureFactory {
    
    static func TemperatureWith(dictionary: [String: Any]) -> Temperature? {
//        print(dictionary["dates"])

        guard
            let _id = dictionary["_id"] as? String,
            let deviceID = dictionary["deviceID"] as? String,
            let date = dictionary["date"] as? String,
            let tempValues = dictionary["tempValues"] as? [Double]
            else{
                return nil
        }

        return Temperature(_id: _id,
                           deviceID: deviceID,
                           date: date,
                           tempValues: tempValues
        );
    }
}
