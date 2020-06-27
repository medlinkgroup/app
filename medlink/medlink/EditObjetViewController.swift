//
//  EditObjetViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditObjetViewController: UIViewController {
    @IBOutlet var label_edit_object: UILabel!
    @IBOutlet var label_object_name: UILabel!
    @IBOutlet var label_is_attributed: UILabel!
    @IBOutlet var btn_edit: UIButton!
    @IBOutlet var btn_is_attributed: UISwitch!
    
    @IBOutlet weak var NameText: UITextField!
    var id : String?
    var editObjet : Objet!
    var objetService: ObjetService{
        return ObjetApiService()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        label_edit_object.text = NSLocalizedString("edit_object", comment: "")
        label_object_name.text = NSLocalizedString("object_name", comment: "")
        label_is_attributed.text = NSLocalizedString("is_attributed", comment: "")
        btn_edit.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        self.id = editObjet._id
        loadData()

        
    }
    
    func newInstance(detail: Objet) -> EditObjetViewController {
        let view = EditObjetViewController()
        view.editObjet = detail
        return view

    }
    
    @IBAction func btn_is_attributed(_ sender: AnyObject) {
        let onState = btn_is_attributed.isOn
        if onState {
            label_is_attributed.text = NSLocalizedString("attributed_on", comment: "")
        } else {
            label_is_attributed.text = NSLocalizedString("attributed_off", comment: "")
        }

    }

    func loadData() {
           if (editObjet != nil){
               
                
            self.NameText.text = editObjet.name
            self.btn_is_attributed.isOn = editObjet.isAttributed
           }
       }
    @IBAction func save_btn(_ sender: Any) {
        guard
                     let id = id,
                     let name = NameText.text,
            
                     
                     
                         id.count > 0,
                         name.count > 0
                       
                         
                     else {
                         
                         self.displayError(message: NSLocalizedString("missing_field", comment: ""))
                         return
                     }
                      let isAttributed = btn_is_attributed.isOn
                           //let email = emailTextField.text,
        self.objetService.edit(id: id, name: name, isAttributed:btn_is_attributed.isOn){
                  (success) in
                  
              }
                    
                         let confirmationAlert = UIAlertController(title: NSLocalizedString("success", comment: ""), message: NSLocalizedString("modif_success", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                                   confirmationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil ))
                                                    
                                                 
                                                   self.present(confirmationAlert, animated: true, completion: nil)
                
    }
    func displayError(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel))
        self.present(alert, animated: true)
    }

}
