//
//  AppDelegate.swift
//  medlink
//
//  Created by Fabiana Montiel on 17/03/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let root =  UINavigationController(rootViewController: HomeViewController())

        //window.rootViewController = UINavigationController(rootViewController:
        //HomeViewController())
        //HomeSignUpViewController())
        //AddPatientViewController())
        
            
        //DocDashboardListViewController())
        //DocProfileListViewController())
        //PatientDetailViewController())

        //EditObjetViewController())

       // LineGraphViewController())

            
        
        //root.setNavigationBarHidden(YES , animated: YES)
        root.isNavigationBarHidden = true
        window.rootViewController = root
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

