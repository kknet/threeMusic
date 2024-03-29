//
//  AppDelegate.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //        把初始视图控制器压入导航视图控制器
        let navigationController = UINavigationController(rootViewController: ViewController())
        //        把根视图控制器设为导航视图控制器
        self.window?.rootViewController = navigationController
        //        渲染出页面
        self.window?.makeKeyAndVisible()


        return true
    }
    // MARK: - CoreData
      lazy var managedObjectModel: NSManagedObjectModel = {
          let modelURL = Bundle.main.url(forResource: "ThreeMusic", withExtension: "momd")
          let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL!)
          return managedObjectModel!
      }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
           let persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
           let sqliteURL = documentDir.appendingPathComponent("Model.sqlite")
           let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
           var failureReason = "创建NSPersistentStoreCoordinator时出现错误"
           
           do {
               try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: options)
           } catch {
               // Report any error we got.
               var dict = [String: Any]()
               dict[NSLocalizedDescriptionKey] = "初始化NSPersistentStoreCoordinator失败" as Any?
               dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?
               dict[NSUnderlyingErrorKey] = error as NSError
               let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 6666, userInfo: dict)
               print("未解决的错误： \(wrappedError), \(wrappedError.userInfo)")
               abort()
           }
           return persistentStoreCoordinator
       }()
       
       lazy var context: NSManagedObjectContext = {
           let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
           context.persistentStoreCoordinator = persistentStoreCoordinator
           return context
       }()
       
       lazy var documentDir: URL = {
           let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
           return documentDir!
       }()

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "ThreeMusic")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

