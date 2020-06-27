//
//  EditObjetViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class EditObjetViewController: UIViewController {

      var editObjet : Objet!
    override func viewDidLoad() {
        super.viewDidLoad()

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
