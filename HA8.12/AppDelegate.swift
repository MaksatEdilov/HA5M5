//
//  AppDelegate.swift
//  HA8.12
//
//  Created by Maksat Edil on 10/12/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    lazy var persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores { description, error in
            if let error  {
                print(error.localizedDescription)
            } else {
                print ("datastore url: \(description.url?.absoluteString ?? "none")")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistenContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as? NSError
                fatalError(error!.localizedDescription)
            }
        }
    }
}

