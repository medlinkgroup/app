//
//  AddObjetViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class AddObjetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var label_add_object: UILabel!
    @IBOutlet var label_object_name: UILabel!
    @IBOutlet var label_is_attributed: UILabel!
    @IBOutlet var btn_add: UIButton!
    @IBOutlet var btn_is_attributed: UISwitch!
    @IBOutlet weak var NameText: UITextField!
    
    @IBOutlet weak var save_Btn: UIButton!
    var objetService: ObjetService{
        return ObjetApiService()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        label_add_object.text = NSLocalizedString("add_object", comment: "")
        label_object_name.text = NSLocalizedString("object_name", comment: "")
        label_is_attributed.text = NSLocalizedString("is_attributed", comment: "")
        btn_add.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
        
        self.NameText.delegate = self
    }
    
    @IBAction func save_object_btn(_ sender: Any) {
        guard let name = NameText.text,
            name.count > 0
            else {
            self.displayError(message: NSLocalizedString("missing_field", comment: ""))
            return
        }
        self.objetService.create( name: name, isAttributed: false) { (success) in
                           print(success)
                       }
        let confirmationAlert = UIAlertController(title: NSLocalizedString("done", comment: ""), message: NSLocalizedString("add_success", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                      confirmationAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil ))
                                       
                                    
                                      self.present(confirmationAlert, animated: true, completion: nil)
                     
                       
    }
    @IBAction func btn_is_attributed(_ sender: AnyObject) {
        let onState = btn_is_attributed.isOn
        if onState {
            label_is_attributed.text = NSLocalizedString("attributed_on", comment: "")
        } else {
            label_is_attributed.text = NSLocalizedString("attributed_off", comment: "")
        }

    }

    func displayError(message: String) {
           let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel))
           self.present(alert, animated: true)
       }


}
