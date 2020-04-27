//
//  NavBarViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/04/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseAuth


class NavBarViewController: UIViewController, UITabBarControllerDelegate {
    
    
    var navBarCont: UITabBarController!

    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    /* navBarCont.tabBar.barTintColor = UIColor.
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
        //optionA.isNavigationBarHidden = false
        optionA.tabBarItem.title="Profil"
        optionA.tabBarItem.image = UIImage(named: "profile_icon")
        
        let optionB = UINavigationController(rootViewController: HomeSignUpViewController())
        
        optionB.isNavigationBarHidden = true
        optionB.tabBarItem.title="Consultations"
        optionB.tabBarItem.image = UIImage(named: "Search")

        let optionC = UINavigationController(rootViewController: ViewController())
          optionC.isNavigationBarHidden = true
          optionC.tabBarItem.title="Add"
          optionC.tabBarItem.image = UIImage(named: "add_icon")
        

     
        navBarCont.viewControllers = [optionA,optionB,optionC]
        self.view.addSubview(navBarCont.view)
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainOrange() -> UIColor {
        return UIColor.rgb(red: 255, green: 189, blue: 89)
    }
    
    static func mainWhite() -> UIColor {
        return UIColor.rgb(red: 255, green: 255, blue: 255)
    }
    
    static func mainBlack() -> UIColor {
          return UIColor.rgb(red: 0, green: 0, blue: 0)
    }
}
