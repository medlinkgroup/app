//
//  DocProfileListViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 23/03/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

class DocProfileListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsSignedIn()
        // Do any additional setup after loading the view.
    }

    private func checkIfUserIsSignedIn() {
    
             let db = Firestore.firestore()

             if Auth.auth().currentUser  == nil {
                 //Check si un user est connecté
                 self.navigationController?.pushViewController(HomeViewController(), animated: false)
             }
     }

}
