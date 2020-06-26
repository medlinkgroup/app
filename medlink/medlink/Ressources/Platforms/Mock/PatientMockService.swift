//
//  PatientMockService.swift
//  medlink
//
//  Created by Fabiana Montiel on 17/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation
import CoreLocation

class PatientMockService: PatientService {
    func create(firstName: String, lastName: String, phone: String, photo: String, email: String, doctorUid: String, place: String, location: CLLocation, birthDate: String, objetUid: String, completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    
    func edit(id: String, firstName: String, lastName: String, phone: String, photo: String, email: String, doctorUid: String, place: String, location: CLLocation, birthDate: String, objetUid: String, completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    
  
    

    
    
   
    func getAll(completion: @escaping ([Patient]) -> Void) {
          completion(self.patients)
      }
      
    
     func delete(id: String, completion: @escaping (Bool) -> Void) {
        completion(false)
      /*self.patients.removeAll(where: { (r) -> Bool in
          
              return r._id == _id
          print(r._id)
          })*/
    }
    
    private var patients: [Patient] = [
       Patient(
            _id: "1",
            firstName: "Madeleine",
            lastName: "Dupont",
            phone: "0652468349",
            photo: URL(string: "http://restaurant-legrey.fr/wp-content/uploads/elementor/thumbs/salle-2-grey-resto-5-nrnp7vsw82tzrpkdb6zrpyu7f9pplh7f9u1qbr6tpc.jpg"),
            email: "madeleine@mail.com",
            doctorUid: "ZTN6IL7T9nZLVcyh1Jkxzhhk73O2",
            place: "10 rue Lafayette 75009 Paris",
            location: CLLocation(latitude: 48.849329, longitude: 2.3875453),
            birthDate: "1963-07-28T00:00:00.000Z",
            objetUid: ""
        ),
        
        Patient(
            _id: "2",
            firstName: "Martin",
            lastName: "Petit",
            phone: "0652468622",
            photo: URL(string: ""),
            email: "martin@mail.com",
            doctorUid: "ZTN6IL7T9nZLVcyh1Jkxzhhk73O2",
            place: "16 rue Médéric 75017 Paris",
            location: CLLocation(latitude: 48.849329, longitude: 2.3875453),
            birthDate: "1984-03-02T00:00:00.000Z",
            objetUid: ""
        ),
        
        Patient(
            _id: "3",
            firstName: "Liliane",
            lastName: "Garnier",
            phone: "0653568347",
            photo: URL(string: ""),
            email: "liliane@mail.com",
            doctorUid: "ggg",
            place: "1 boulevard Sebastopool 75004 Paris",
            location: CLLocation(latitude: 48.849329, longitude: 2.3875453),
            birthDate: "1994-01-12T00:00:00.000Z",
            objetUid: ""
        ),
        
        Patient(
            _id: "4",
            firstName: "Bernard",
            lastName: "Duval",
            phone: "0754644634",
            photo: URL(string: ""),
            email: "bernard@mail.com",
            doctorUid: "jjj",
            place: "63 rue de Rivoli 75001 Paris",
            location: CLLocation(latitude: 48.849329, longitude: 2.3875453),
            birthDate: "1972-10-05T00:00:00.000Z",
            objetUid: ""
        )
        
        
    ]
    
}
