//
//  PatientFactory.swift
//  
//
//  Created by cylia boukhiba on 20/06/2020.
//

import Foundation
import CoreLocation


class PatientFactory {
    
    static func PatientWith(dictionary: [String: Any]) -> Patient? {
//        print(dictionary["dates"])
       
        guard
            let _id = dictionary["_id"] as? String,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let phone = dictionary["phone"] as? String,
            let email = dictionary["email"] as? String,
            let place = dictionary["place"] as? String,
            let doctorUid = dictionary["doctorUid"] as? String,
            let location = dictionary["location"] as? [String: CLLocationDegrees],
            let lat = location["latitude"],
            let lon = location["longitude"],
            let birthDate = dictionary["birthDate"] as? String
            else{
                         return nil
                 }
         
        let photo = dictionary["photo"] as? String

        return Patient(_id: _id,
                     firstName: firstName,
                     lastName: lastName,
                     phone: phone,
                     photo: photo != nil ? URL(string: photo!) : nil,
                     email: email,
                     doctorUid: doctorUid,
                     place: place,
                     location: CLLocation(latitude: lat, longitude: lon),
                     birthDate: birthDate
                    
        );
    }
}


