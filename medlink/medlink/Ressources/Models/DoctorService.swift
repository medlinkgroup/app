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
    
   
   // func edit(  id: String ,title: String, description: String,freeText: String, pictureURL: String ,email: String, creatorUid: String, place: String, location: CLLocation,  date: String, category: String,  timeStart: String, timeEnd: String, address: String, completion: @escaping (Bool) -> Void)
   
    //  all reservation by id user
    //func getByIdUser(id: String, completion: @escaping ([Doctor]) -> Void)


}
