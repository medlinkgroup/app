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

        let optionA = UINavigationController(rootViewController: DocDashboardListViewController())
        //optionD.isNavigationBarHidden = false
        optionA.tabBarItem.title = NSLocalizedString("home", comment: "")
        let image4 = UIImage(named: "Home")
        optionA.tabBarItem.image = image4
        
        let optionB = UINavigationController(rootViewController: PatientsListViewController())
        //optionD.isNavigationBarHidden = false
        optionB.tabBarItem.title = NSLocalizedString("list_patients", comment: "")
        let image2 = UIImage(named: "list_patients")
        optionB.tabBarItem.image = image2
        
        let optionC = UINavigationController(rootViewController: DocAccountViewController())
        optionC.setNavigationBarHidden(true, animated: true)
        //optionA.isNavigationBarHidden = true
        optionC.tabBarItem.title = NSLocalizedString("view_profile", comment: "")
        let image1 = UIImage(named: "Account")
        optionC.tabBarItem.image  = image1
        
        
        let optionD = UINavigationController(rootViewController: ObjetsListViewController())
        //optionD.isNavigationBarHidden = false
        optionD.tabBarItem.title = NSLocalizedString("list_objects", comment: "")
        let image3 = UIImage(named: "list_objects")
        optionD.tabBarItem.image = image3
    
     
        navBarCont.viewControllers = [optionA, optionB, optionC, optionD]
        self.view.addSubview(navBarCont.view)
    }
}




