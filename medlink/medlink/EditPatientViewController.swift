//
//  EditPatientViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import CoreLocation

class EditPatientViewController: UIViewController {

    
    @IBOutlet var label_modify_patient: UILabel!
    @IBOutlet var label_name: UILabel!
    @IBOutlet var label_last_name: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_phone: UILabel!
    @IBOutlet var label_img: UILabel!
    @IBOutlet var label_adress: UILabel!
    @IBOutlet var label_email: UILabel!
    @IBOutlet var label_object_id: UILabel!
    @IBOutlet var btn_upload_image: UIButton!
    @IBOutlet var btn_modify_patient: UIButton!
    
    @IBOutlet var FirstNameText: UITextField!
    @IBOutlet var LastNameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PhoneText: UITextField!
    @IBOutlet var PlaceText: UITextField!
    @IBOutlet var ImageURLText: UITextField!
    @IBOutlet var DateText: UITextField!
    @IBOutlet var PhotoView: UIImageView!
    @IBOutlet var ObjectText: UITextField!
    
    
    
    var objet : Objet!
    var editPatient : Patient!
    
    var objetService: ObjetService{
        return ObjetApiService()
    }
    override func viewDidAppear(_ animated: Bool) {
       
               self.objetService.getAll { (objets) in
                          print(objets)
                   self.objet = objets.first(where: { (objet) -> Bool in
                    objet._id == self.editPatient.objetUid
                       })
                if (self.objet != nil){
                    self.ObjectText.text = self.objet.name
                }
                      
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        label_modify_patient.text = NSLocalizedString("modify_patient", comment: "")
        label_name.text = NSLocalizedString("firstname", comment: "")
        label_last_name.text = NSLocalizedString("lastname", comment: "")
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_object_id.text = NSLocalizedString("objectid", comment: "")
        btn_modify_patient.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        btn_upload_image.setTitle(NSLocalizedString("upload", comment: ""), for: .normal)
        
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_phone.text = NSLocalizedString("phone_number", comment: "")
        label_img.text = NSLocalizedString("image", comment: "")
        label_adress.text = NSLocalizedString("adress", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        // Do any additional setup after loading the view.
        loadData()
    }


  func newInstance(detail: Patient) -> EditPatientViewController {
            let view = EditPatientViewController()
            view.editPatient = detail
            return view
            
        }
     
    func loadData() {
           if (editPatient != nil){
               
                viewDidAppear(true)
            self.FirstNameText.text = editPatient.firstName
               self.LastNameText.text = editPatient.lastName
               self.EmailText.text = editPatient.email
               self.PhoneText.text = editPatient.phone
               self.PlaceText.text = editPatient.place
               self.DateText.text = editPatient.birthDate
              //self.ObjectText.text = objet._id
               
            if let pictureURL = editPatient.photo {
                      DispatchQueue.global().async {
                          if let data = try? Data(contentsOf: pictureURL) {
                              DispatchQueue.main.sync {
                               self.PhotoView.image = UIImage(data: data)
                              }
                          }
                      }
                  }
            
         
           
               let url = editPatient.photo
               let urlString = url?.absoluteString
               self.ImageURLText.text = urlString
              
           }
           
        self.PlaceText.text = editPatient.place
       }
      
     

}
