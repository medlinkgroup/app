//
//  DocHomeViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

class DocHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsSignedIn()

    }
   private func checkIfUserIsSignedIn() {
      
               let db = Firestore.firestore()

               if Auth.auth().currentUser  == nil {
                   //Check si un user est connecté
                   self.navigationController?.pushViewController(HomeViewController(), animated: false)
               }
       }


}
