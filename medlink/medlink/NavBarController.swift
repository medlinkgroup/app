//
//  NavBarController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

class NavBarController: UITabBarController , UITabBarControllerDelegate {
    
    
    var navBarCont: UITabBarController!

    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*navBarCont.tabBar.barTintColor = UIColor.yellow
        var tabFrame = self.navBarCont.tabBar.frame
        tabFrame.size.height = 50
       tabFrame.origin.y = self.view.frame.size.height - 50*/
        setupTabBar()
        // enlever toute la bar
       self.navigationController?.isNavigationBarHidden = true


        // Do any additional setup after loading the view.
    }


    
    
    func setupTabBar(){
        navBarCont = UITabBarController()
        
        navBarCont.delegate = self
        

        let optionA = UINavigationController(rootViewController: HomeViewController())
        optionA.setNavigationBarHidden(true, animated: true)
        optionA.isNavigationBarHidden = true
        optionA.tabBarItem.title="Account"
        let image1 = UIImage(named: "profile_icon")
        optionA.tabBarItem.image  = image1
        
        
        let optionB = UINavigationController(rootViewController: HomeSignUpViewController())
        
        optionB.isNavigationBarHidden = true
        optionB.tabBarItem.title="Consultations"
        optionB.tabBarItem.image = UIImage(named: "Search")

        let optionC = UINavigationController(rootViewController: ViewController())
        optionC.isNavigationBarHidden = true
        optionC.tabBarItem.title="Add"
        let image2 = UIImage(named: "profile_icon")
          optionC.tabBarItem.image = image2
        

     
        navBarCont.viewControllers = [optionA,optionB,optionC]
        self.view.addSubview(navBarCont.view)
    }
}




