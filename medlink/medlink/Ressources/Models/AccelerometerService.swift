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

    
}
