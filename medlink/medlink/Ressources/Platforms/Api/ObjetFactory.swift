//
//  ObjetFactory.swift
//  medlink
//
//  Created by cylia boukhiba on 26/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation


class ObjetFactory {
    
    static func ObjetWith(dictionary: [String: Any]) -> Objet? {
//        print(dictionary["dates"])
       
        guard
            let _id = dictionary["_id"] as? String,
            let name = dictionary["name"] as? String,
            let isAttributed = dictionary["isAttributed"] as? Bool
            else{
                return nil
        }

        return Objet(_id: _id,
                     name: name,                     
                     isAttributed: isAttributed
        );
    }
}


