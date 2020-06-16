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
            let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
            let freeText = dictionary["freeText"] as? String,
            let email = dictionary["email"] as? String,
            let creatorUid = dictionary["CreatorUid"] as? String,
            let place = dictionary["place"] as? String,
            let location = dictionary["location"] as? [String: CLLocationDegrees],
            let lat = location["latitude"],
            let lon = location["longitude"],
            let date = dictionary["date"] as? String,
            let category = dictionary["category"] as? String,
            let timeStart = dictionary["timeStart"] as? String,
            let timeEnd = dictionary["timeEnd"] as? String,
            let address = dictionary["address"] as? String
            else {
                    return nil
            }
        let pictureURL = dictionary["pictureURL"] as? String

        return Doctor(_id: _id,
                     title: title,
                     description: description,
                     freeText: freeText,
                     pictureURL: pictureURL != nil ? URL(string: pictureURL!) : nil,
                     email: email,
                     creatorUid: creatorUid,
                     place: place,
                     location: CLLocation(latitude: lat, longitude: lon),
                     date: date,
                     category: category,
                     timeStart: timeStart,
                     timeEnd: timeEnd,
                     address: address
        );
    }
}

