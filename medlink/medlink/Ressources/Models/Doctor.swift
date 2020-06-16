//
//  Doctor.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

struct Doctor {
    var _id: String
    var first_name: String
    var last_name: String
    var phone_number: String
    var photo: URL?
    var email: String
    var birth_date: String
    var specialty: String
    var creatorUid: String
    var place: String
    var location: CLLocation
  
}
/*struct Doctor {
    var id: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var phone_number: String = ""
    var photo: String = ""
    var email: String = ""
    var birth_date: String = ""
    var specialty: String = ""
    //var password: String = ""
    
    
    init(id: String, email: String, password: String) {
        self.id = id
        self.email = email
        //self.password = password
    }
    
    
    init(id: String, first_name: String, last_name: String, phone_number: String, photo: String, email: String, birth_date: String, specialty: String/*, password: String*/) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.photo = photo
        self.email = email
        self.birth_date = birth_date
        self.specialty = specialty
        //self.password = password
    }
    
    func dictionnary() -> [String : Any] {
        return [
            "doctor_uid": self.id,
            "name": self.first_name,
            "familyName": self.last_name,
            "numberPhone": self.phone_number,
            "photo": self.photo,
            "email": self.email,
            "birthDate": self.birth_date,
            "speciality": self.specialty,
            //"password": self.password
        ]
    }
}*/
