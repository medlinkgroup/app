//
//  ConsultationCallAPI.swift
//  medlink
//
//  Created by Fabiana Montiel on 15/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import Alamofire

class ConsultationCallAPI: ConsultationCall {
    
    private let url: String = "https://medlinkapi.herokuapp.com"
    
    func all(completion: @escaping ([Consultation]) -> Void) {
        AF.request(self.url + "/all", method: .get).responseJSON { (request) in
            guard
                let items = request.value as? [[String:Any]]
            else {
                completion([])
                return
            }
            completion(items.compactMap(ConsultationUtils.map(item:)))
        }
    }
    
    func one(_ id: Int, completion: @escaping (Consultation?) -> Void) {
        AF.request(self.url + "/\(String(id))", method: .get).responseJSON { (request) in
            guard
                let item = request.value as? [String:Any]
            else {
                completion(nil)
                return
            }
            completion(ConsultationUtils.map(item: item))
        }
    }
    
    func save(object: Consultation, completion: @escaping (Consultation?) -> Void) {
        AF.request(self.url, method: .post, parameters: object.dictionnary(), encoding: JSONEncoding.default).responseJSON { (request) in
            guard
                let item = request.value as? [String:Any]
            else {
                completion(nil)
                return
            }
            completion(ConsultationUtils.map(item: item))
        }
    }
    
    func update(_ id: Int, object: Consultation, completion: @escaping (Consultation?) -> Void) {
        AF.request(self.url + "/\(String(id))", method: .patch, parameters: object.dictionnary(), encoding: JSONEncoding.default).responseJSON { (request) in
            guard
                let item = request.value as? [String:Any]
            else {
                completion(nil)
                return
            }
            completion(ConsultationUtils.map(item: item))
        }
    }
    
    func delete(_ id: Int, completion: @escaping (Bool) -> Void) {
        AF.request(self.url + "/\(String(id))", method: .delete).responseJSON { (request) in
            completion(request.response?.statusCode == 200)
        }
    }
}
