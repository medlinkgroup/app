//
//  AccelerometerFactory.swift
//  medlink
//
//  Created by Fabiana Montiel on 21/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

class AccelerometerFactory {
    
    static func AccelerometerWith(dictionary: [String: Any]) -> Accelerometer? {
//        print(dictionary["dates"])

        guard
            let _id = dictionary["_id"] as? String,
            let deviceID = dictionary["deviceID"] as? String,
            let date = dictionary["date"] as? String,
            let accelerometerXValues = dictionary["accelerometerXValues"] as? [Double],
            let accelerometerYValues = dictionary["accelerometerYValues"] as? [Double],
            let accelerometerZValues = dictionary["accelerometerZValues"] as? [Double]
            else{
                return nil
        }

        return Accelerometer(_id: _id,
                             deviceID : deviceID,
                             date : date,
                             accelerometerXValues : accelerometerXValues,
                             accelerometerYValues : accelerometerYValues,
                             accelerometerZValues : accelerometerZValues
        );
    }
}
