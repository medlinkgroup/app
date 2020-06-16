//
//  consultationCall.swift
//  medlink
//
//  Created by Fabiana Montiel on 15/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

protocol ConsultationCall {
    
    
    func all(completion: @escaping ([Consultation]) -> Void)
    func one(_ id: Int, completion: @escaping (Consultation?) -> Void)
    func save(object: Consultation, completion: @escaping (Consultation?) -> Void)
    func update(_ id: Int, object: Consultation, completion: @escaping (Consultation?) -> Void)
    func delete(_ id: Int, completion: @escaping (Bool) -> Void)
     
}
