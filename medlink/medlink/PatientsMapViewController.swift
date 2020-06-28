//
//  PatientsMapViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore
fileprivate class PatientAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return self.patients.location.coordinate
    }
    var title: String? {
        return self.patients.lastName + "  " + self.patients.lastName
    }
    let patients: Patient
 
    
    init(patient: Patient) {
        self.patients = patient
        super.init()
    }
    
}

class PatientsMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var patientMapView: MKMapView!
       var DoctorUID: String = ""
    var patientService: PatientService {
        return PatientAPIService()
    }
    var patients: [Patient] = [] {
        didSet {
            self.patientMapView.addAnnotations(self.patients.map({ PatientAnnotation(patient: $0)}))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.patientMapView.delegate = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser{
            let docRef = db.collection("users").document(user.uid)
            self.DoctorUID = user.uid
            print(docRef)
        
           docRef.getDocument { (document, error) in
                
            
              if let document = document, document.exists {
              
                   print(document.data()!)
                self.DoctorUID = document["uid"]! as! String
                   } else {
                       print("DOCTOR UID NOT FOUND : Document does not exist")
                   }
               }
            } else {
                //fatalError(" Erreur : aucun user connect")
                print("no user connected")
            }
        
           

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
         self.patientService.getAll { (patients) in
            self.patients = patients.filter({$0.doctorUid == self.DoctorUID})
         }
     }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            if let patientAnnotation = annotation as? PatientAnnotation {
                let e = patientAnnotation.patients
                let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
                if e.photo == nil {
                    pin.pinTintColor = .purple
                } else {
                    pin.pinTintColor = .yellow
                }
                pin.canShowCallout = true
                let button = UIButton(type: .infoDark)
                let index = self.patients.firstIndex { $0._id == e._id }
    //            let index2 = self.restaurants.firstIndex { (resto) -> Bool in
    //                return resto.id == r.id
    //            }
                button.tag = index ?? -1
                button.addTarget(self, action: #selector(touchCallout(_:)), for: .touchUpInside)
                pin.rightCalloutAccessoryView = button
                return pin
            }
            return nil
        }
        
        @objc func touchCallout(_ sender: UIButton) {
            let patient = self.patients[sender.tag]
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(patient.location) { (placemarks, err) in
                guard err == nil,
                      let place = placemarks?.first else {
                        return
                }
                print(place) // Affiche l'adresse
              
              
                
           
                let confirmationAlert = UIAlertController(title: NSLocalizedString("adress", comment: "") , message: patient.place, preferredStyle: UIAlertController.Style.alert)
                                            confirmationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil ))
                                            self.present(confirmationAlert, animated: true, completion: nil)
                           
                         }
            }
        

}
