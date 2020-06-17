//
//  DoctorFactory.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation


class DoctorFactory {
    
    static func DoctorWith(dictionary: [String: Any]) -> Doctor? {
//        print(dictionary["dates"])
        
        guard
            let _id = dictionary["_id"] as? String,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let phone = dictionary["phone"] as? String,
            let email = dictionary["email"] as? String,
            let birthDate = dictionary["birthDate"] as? String,
            let field = dictionary["field"] as? String,
            let photo = dictionary["photo"] as? String
            else{
                return nil
        }

        return Doctor(_id: _id,
                     firstName: firstName,
                     lastName: lastName,
                     phone: phone,
                     photo: photo != nil ? URL(string: photo) : nil,
                     email: email,
                     birthDate: birthDate,
                     field: field
        );
    }
}

