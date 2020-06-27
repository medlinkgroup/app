//
//  ObjetService.swift
//  medlink
//
//  Created by cylia boukhiba on 26/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

protocol ObjetService{
    func getAll(completion: @escaping ([Objet]) -> Void)
    
    func create(name: String, isAttributed: Bool, completion: @escaping (Bool) -> Void)
     func delete(id: String, completion: @escaping (Bool) -> Void)
    
     func edit(id: String,name: String, isAttributed: Bool, completion: @escaping (Bool) -> Void)
    
     //  all reservation by id user
    

}
