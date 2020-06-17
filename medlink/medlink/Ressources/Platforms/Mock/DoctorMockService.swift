//
//  DoctorMockService.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import Foundation

class DoctorMockService: DoctorService {
    
 
    
   
    
    func getAll(completion: @escaping ([Doctor]) -> Void) {
          completion(self.doctors)
      }
    
    private var doctors: [Doctor] = [
        Doctor(_id: "1",
              firstName: "event1",
              lastName: "event1des",
              phone: "event1 freetaxt",
              photo: URL(string:  "http://restaurant-legrey.fr/wp-content/uploads/elementor/thumbs/salle-2-grey-resto-5-nrnp7vsw82tzrpkdb6zrpyu7f9pplh7f9u1qbr6tpc.jpg"),
              email: "cylia@gmail.com",
              birthDate: "2019-12-26T00:00:00.000Z",
              field: "Action"
              ),
        Doctor(_id: "2",
              firstName: "event2",
        lastName: "event1des",
        phone: "event1 freetaxt",
        photo: URL(string:  "http://restaurant-legrey.fr/wp-content/uploads/elementor/thumbs/salle-2-grey-resto-5-nrnp7vsw82tzrpkdb6zrpyu7f9pplh7f9u1qbr6tpc.jpg"),
        email: "cylia@gmail.com",
        birthDate: "2019-12-26T00:00:00.000Z",
        field: "Action"
        ),
        Doctor(_id: "3",
              firstName: "event3",
              lastName: "event3des",
              phone: "event3 freetaxt",
              photo: URL(string:  "http://restaurant-legrey.fr/wp-content/uploads/elementor/thumbs/salle-2-grey-resto-5-nrnp7vsw82tzrpkdb6zrpyu7f9pplh7f9u1qbr6tpc.jpg"),
              email: "f@gmail.com",
              birthDate: "2020-11-12T00:00:00.000Z",
              field: "Action"
              ),
        Doctor(_id: "4",
              firstName: "event4",
        lastName: "event4des",
        phone: "event4 freetaxt",
        photo: URL(string:  "http://restaurant-legrey.fr/wp-content/uploads/elementor/thumbs/salle-2-grey-resto-5-nrnp7vsw82tzrpkdb6zrpyu7f9pplh7f9u1qbr6tpc.jpg"),
        email: "f@gmail.com",
        birthDate: "2019-03-04T00:00:00.000Z",
        field: "Action"
        )
        
    ]
    
}
