//
//  AddPatientViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class AddPatientViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var label_add_patient: UILabel!
    @IBOutlet var label_name: UILabel!
    @IBOutlet weak var label_lastname: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_object_id: UILabel!
    @IBOutlet var btn_add_patient: UIButton!
    @IBOutlet weak var btn_upload_image: UIButton!
    @IBOutlet weak var FirstNameText: UITextField!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PhoneText: UITextField!
    @IBOutlet weak var PlaceText: UITextField!
    @IBOutlet weak var ImageURLText: UITextField!
    @IBOutlet weak var DateText: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    
    
    let imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    var UidDoc : String?
    
      

      let db = Firestore.firestore()
      
     var patientService: PatientService{
          return PatientAPIService()
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = Auth.auth().currentUser {
                         // user connect
                         let docRef = db.collection("users").document(user.uid)
                         
                        docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            //print(document.data()!)
                         self.UidDoc = document["uid"] as? String
                             
                            } else {
                                print("Document does not exist")
                            }
                        }
                     } else {
                         fatalError(" Erreur : aucun user connect")
                     }
                   self.FirstNameText.delegate = self
                   self.LastNameText.delegate = self
                   self.EmailText.delegate = self
                   self.PhoneText.delegate = self
                   self.PlaceText.delegate = self
                   self.DateText.delegate = self
                   self.ImageURLText.delegate = self
                  
                 
                 //  createDatePicker()
              
                  
                 //  imagePicker.delegate = self
                  

       
    }
    
    func uploadPatientImage(imageData: Data)  {
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
           activityIndicator.startAnimating()
           activityIndicator.center = self.view.center
           self.view.addSubview(activityIndicator)
        
           
           let storageReference = Storage.storage().reference()
           //let currentUser = Auth.auth().currentUser
           
           //let eventRef = db.collection("events").document()
           var patientRef: DocumentReference? = nil
           patientRef = db.collection("patients").addDocument(data: [
                "PatientId": "1",
                "patientImage": ""
                ])
           { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(patientRef!.documentID)")
                    }
            }

        let patientImageRef = storageReference.child("patients").child("\(patientRef!.documentID)-patientImage.jpg")

        
           let uploadMetaData = StorageMetadata()
           uploadMetaData.contentType = "image/jpeg"
           
           patientImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
              
               activityIndicator.stopAnimating()
               activityIndicator.removeFromSuperview()
               
               if error != nil
               {
                   print("Error took place \(String(describing: error?.localizedDescription))")
                   return
               } else {
                   
                  // self.imageView.image = UIImage(data: imageData)
                   
                   print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
                patientImageRef.downloadURL(completion: {(url, error) in
                    if let urlText = url?.absoluteString
                    {
                        self.ImageURLText.text = urlText
                        }
                    })
                }
                }

    }
    

}
extension AddPatientViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let optimizedImageData =
          editedImage.jpegData(compressionQuality: 0.5)
      {
          self.photoView.image = editedImage
          //uploadPatientImage(imageData: optimizedImageData)
      }
      
      if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ,let optimizedImageData =
         originalImage.jpegData(compressionQuality: 0.5)
          {
              self.photoView.image = originalImage
             // uploadPatientImage(imageData: optimizedImageData)
          }
      dismiss(animated: true, completion: nil)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion:nil)
    }
}
