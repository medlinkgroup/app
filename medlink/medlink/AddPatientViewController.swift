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
import MobileCoreServices
import CoreLocation

class AddPatientViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate {

    @IBOutlet var label_add_patient: UILabel!
    @IBOutlet var label_name: UILabel!
    @IBOutlet weak var label_lastname: UILabel!
    @IBOutlet var label_birthdate: UILabel!
    @IBOutlet var label_phone: UILabel!
    @IBOutlet var label_img: UILabel!
    @IBOutlet var label_adress: UILabel!
    @IBOutlet var label_email: UILabel!
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
    @IBOutlet weak var ObjectText: UITextField!
    
    let objectPicker = UIPickerView()
    let imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    var UidDoc : String?
    
     var objects = [Objet] ()
    var selectedObjectId: String?
    var selectedObjectName: String?

      let db = Firestore.firestore()
      
     var patientService: PatientService{
        return PatientAPIService()
        //return PatientMockService()
      }
    var objetService: ObjetService{
              return ObjetApiService()
          }
    
    override func viewDidAppear(_ animated: Bool) {
           self.objetService.getAll { (objects) in
               print(objects)
               self.objects = objects
               // filter just doctorId
               
               print(self.objects)
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_add_patient.text = NSLocalizedString("add_patient", comment: "")
        label_name.text = NSLocalizedString("firstname", comment: "")
        label_lastname.text = NSLocalizedString("lastname", comment: "")
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_object_id.text = NSLocalizedString("objectid", comment: "")
        btn_add_patient.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        btn_upload_image.setTitle(NSLocalizedString("upload", comment: ""), for: .normal)
        
        label_birthdate.text = NSLocalizedString("birthdate", comment: "")
        label_phone.text = NSLocalizedString("phone_number", comment: "")
        label_img.text = NSLocalizedString("image", comment: "")
        label_adress.text = NSLocalizedString("adress", comment: "")
        label_email.text = NSLocalizedString("email", comment: "")
        
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
                   self.imagePicker.delegate = self
                   self.ObjectText.delegate = self
                 
                   createDatePicker()
                   createObjetPicker()
              
                  
                   
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func upload_image_btn(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
                                imagePicker.mediaTypes = [kUTTypeImage as String]
                                imagePicker.delegate = self
                                present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func add_patient_btn(_ sender: Any) {
        guard let place = PlaceText.text,
              let firstName = FirstNameText.text,
              let lastName = LastNameText.text,
              let email = EmailText.text,
              let date = DateText.text,
              let phone = PhoneText.text,
              let doctorUid = UidDoc ,
              
        
              let imageURL = ImageURLText.text,
            
            let  patient =  ObjectText.text,
            
              firstName.count > 0,
              lastName.count > 0,
              email.count > 0,
              place.count > 0,
              date.count > 0,
              phone.count > 0,
              doctorUid.count > 0
            //objetUid.count > 0
             else {
                self.displayError(message: "Missing required field")
            return
        }
          
          let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place) { (placemarks, err) in
            guard err == nil,
                  let allPlacemarks = placemarks,
                  let placeloc = allPlacemarks.first,
                  let loc = placeloc.location else {
                    self.displayError(message: "Address not found")
                    return
            }
          self.patientService.create(firstName: firstName, lastName: lastName, phone: phone,
                                   photo: imageURL,email: email, doctorUid: doctorUid,
                                   place: place, location: loc, birthDate: date, objetUid: self.selectedObjectId ?? ""
                                   )
          { (success) in
              print (loc)
              print(success)
             
                                 
          }
          let confirmationAlert = UIAlertController(title: "Succes", message: " creation succes.", preferredStyle: UIAlertController.Style.alert)
                             confirmationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil ))
                              
                           
                             self.present(confirmationAlert, animated: true, completion: nil)
            
          }
    }
    func displayError(message: String) {
              let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
              self.present(alert, animated: true)
          }
    func createObjetPicker(){
        //categoryPicker.tag = 1
                ObjectText.inputView = objectPicker
                objectPicker.delegate = self
                let toolBar = UIToolbar()
                toolBar.sizeToFit()
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self,
                action: #selector(AddPatientViewController.doneObjetPicker))
                toolBar.setItems([doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                ObjectText.inputAccessoryView = toolBar
    }
    @objc func doneObjetPicker() {
        
        self.view.endEditing(true)
                
    }
    func createDatePicker(){
       // datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
         toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddPatientViewController.donedatePicker ))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
    DateText.inputAccessoryView = toolbar
    DateText.inputView = datePicker
        
    }
    @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
        DateText.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
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
extension AddPatientViewController:  UIImagePickerControllerDelegate,
UIPickerViewDataSource, UINavigationControllerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return objects.count
        print(objects.count)
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           //return patientsName[row]
           return objects[row].name
       }
       
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           
           //selectedPatient = patientsName[row]
           selectedObjectId = objects[row]._id
           selectedObjectName = objects[row].name
        print(selectedObjectName)
           ObjectText.text = selectedObjectName
        print(ObjectText)
       }
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let optimizedImageData =
          editedImage.jpegData(compressionQuality: 0.5)
      {
          self.photoView.image = editedImage
          uploadPatientImage(imageData: optimizedImageData)
      }
      
      if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ,let optimizedImageData =
         originalImage.jpegData(compressionQuality: 0.5)
          {
              self.photoView.image = originalImage
              uploadPatientImage(imageData: optimizedImageData)
          }
      dismiss(animated: true, completion: nil)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion:nil)
    }
}
