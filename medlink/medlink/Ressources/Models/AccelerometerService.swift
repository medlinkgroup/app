//
//  AccelerometerService.swift
//  medlink
//
//  Created by Fabiana Montiel on 21/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

protocol AccelerometerService{
    
    func getAll(completion: @escaping ([Accelerometer]) -> Void)

    func create(_id: String, deviceID: String, date: String, accelerometerXValues: [Double], accelerometerYValues: [Double], accelerometerZValues: [Double], completion: @escaping (Bool) -> Void)
    
    func delete(_id: String, completion: @escaping (Bool) -> Void)
    
    func edit(_id: String, deviceID: String, date: String, accelerometerXValues: [Double], accelerometerYValues: [Double], accelerometerZValues: [Double], completion: @escaping (Bool) -> Void)
    
}
