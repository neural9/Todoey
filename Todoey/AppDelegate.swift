//
//  AppDelegate.swift
//  Todoey
//
//  Created by Robert Ellis on 17/01/2019.
//  Copyright © 2019 Robert Ellis. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print (Realm.Configuration.defaultConfiguration.fileURL)

        do{
            _ = try Realm()

        }catch{
            print ("ERROR - init Realm, \(error)")
        }
        
        return true
    }

    
    // MARK: - Core Data stack
    
    

}

