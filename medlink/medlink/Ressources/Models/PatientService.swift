//
//  PatientService.swift
//  medlink
//
//  Created by cylia boukhiba on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

protocol PatientService{
    func getAll(completion: @escaping ([Patient]) -> Void)
    
     func create(id: String, firstName: String, lastName: String, phone: String, photo: URL, email: String, place: String, location: CLLocation, birthDate: String, completion: @escaping (Bool) -> Void)
     func delete(id: String, completion: @escaping (Bool) -> Void)
    
     func edit(id: String, firstName: String, lastName: String, phone: String, photo: URL, email: String, place: String, location: CLLocation, birthDate: String, completion: @escaping (Bool) -> Void)
    
     //  all reservation by id user
    

}
