//
//  DoctorService.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

protocol DoctorService {
    
    func getAll(completion: @escaping ([Doctor]) -> Void)
    


}
