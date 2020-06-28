//
//  TemperatureService.swift
//  medlink
//
//  Created by Fabiana Montiel on 21/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

protocol TemperatureService{
    
    func getAll(completion: @escaping ([Temperature]) -> Void)

   
}
