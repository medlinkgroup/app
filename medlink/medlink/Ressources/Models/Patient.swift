//
//  Patient.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

struct Patient {
    
    var _id: String
    var firstName: String
    var lastName: String
    var phone: String
    var photo: URL?
    var email: String
    var doctorUid: String
    var place: String
    var location: CLLocation
    var birthDate: String
    var objetUid : String
    
}
