//
//  NavBarController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class NavBarController: UITabBarController , UITabBarControllerDelegate {
    
    
    var navBarCont: UITabBarController!

    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
       self.navigationController?.isNavigationBarHidden = true


        // Do any additional setup after loading the view.
    }


    
    
    func setupTabBar(){
        navBarCont = UITabBarController()
        
        navBarCont.delegate = self
        
        let optionD = UINavigationController(rootViewController: DocDashboardListViewController())
        optionD.isNavigationBarHidden = false
        optionD.tabBarItem.title="Home"
        let image4 = UIImage(named: "Home")
        optionD.tabBarItem.image = image4
        
        let optionA = UINavigationController(rootViewController: DocAccountViewController())
        optionA.setNavigationBarHidden(true, animated: true)
        optionA.isNavigationBarHidden = true
        optionA.tabBarItem.title="Account"
        let image1 = UIImage(named: "Account")
        optionA.tabBarItem.image  = image1
        

        let optionC = UINavigationController(rootViewController: PatientsListViewController())
        optionC.isNavigationBarHidden = true
        optionC.tabBarItem.title="Patients"
        let image3 = UIImage(named: "")
        optionC.tabBarItem.image = image3
        
    
     
        navBarCont.viewControllers = [optionD, optionC, optionA]
        self.view.addSubview(navBarCont.view)
    }
}




