//
//  AddObjetViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class AddObjetViewController: UIViewController {
    
    @IBOutlet var label_add_object: UILabel!
    @IBOutlet var label_object_name: UILabel!
    @IBOutlet var label_is_attributed: UILabel!
    @IBOutlet var btn_add: UIButton!
    @IBOutlet var btn_is_attributed: UISwitch!

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
    }
    
    @IBAction func btn_is_attributed(_ sender: AnyObject) {
        let onState = btn_is_attributed.isOn
        if onState {
            label_is_attributed.text = NSLocalizedString("attributed_on", comment: "")
        } else {
            label_is_attributed.text = NSLocalizedString("attributed_off", comment: "")
        }

    }



}
