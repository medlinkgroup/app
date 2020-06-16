//
//  PatientsListViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 16/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class PatientsListViewController: UIViewController {

    @IBOutlet weak var label_patients: UILabel!
    @IBOutlet weak var label_my_patients: UILabel!
    @IBOutlet weak var tableview_list_patients: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthCheck()
        
        // Do any additional setup after loading the view.
    }
    private func AuthCheck(){

           if (Auth.auth().currentUser?.uid) == nil {
                 self.navigationController?.setViewControllers([HomeViewController()], animated: false)
           }
           
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
