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
    
    var editObjet : Objet!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_edit_object.text = NSLocalizedString("edit_object", comment: "")
        label_object_name.text = NSLocalizedString("object_name", comment: "")
        label_is_attributed.text = NSLocalizedString("is_attributed", comment: "")
        btn_edit.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
    }
    func newInstance(detail: Objet) -> EditObjetViewController {
               let view = EditObjetViewController()
               view.editObjet = detail
               return view
               
           }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
