//
//  Patient.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

struct Patient {
    
    var first_name: String
    var last_name: String
    var phone_number: String
    var photo: String
    var email: String
    var adress: String
    var birth_date: String
    var location: Location
    
    
    func dictionnary() -> [String : Any] {
        return [
            "name": self.first_name,
            "familyName": self.last_name,
            "numberPhone": self.phone_number,
            "photo": self.photo,
            "email": self.email,
            "address": self.adress,
            "location": self.location,
            "birthDate": self.birth_date
        ]
    }
    
}
