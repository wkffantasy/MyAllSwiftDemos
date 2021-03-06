//
//  AppDelegate.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit
import CoreData

//import SwiftyBeaver
//let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKey()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = TabBarController()

        settingUpLog()
        add3DTouchItems()
        //        makeFiles()
        return true
    }

    func makeFiles() {
        // 创建 图片 和 视频的文件
        makeFilesWithName(fileName: "AllLocalIcons")
        makeFilesWithName(fileName: "AllLocalVedios")
    }

    func makeFilesWithName(fileName: String) {
        var filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        filePath = filePath.appendingPathComponent(fileName) as NSString
        let exist = FileManager.default.fileExists(atPath: filePath as String)
        print("exist ==", exist)
        print("filePath ==", filePath)
        if exist == false {
            do {
                try FileManager.default.createDirectory(atPath: filePath as String, withIntermediateDirectories: false, attributes: nil)
            } catch {
//                log.error("创建\(fileName)失败")
            }
        }
    }

    func add3DTouchItems() {

        // custom image
        let itemIcon1 = UIApplicationShortcutIcon.init(templateImageName: "snow.ico")
        let itemIcon2 = UIApplicationShortcutIcon.init(templateImageName: "snow.ico")
        let itemIcon3 = UIApplicationShortcutIcon.init(templateImageName: "snow.ico")

        let item1 = UIApplicationShortcutItem.init(type: "1", localizedTitle: "test1", localizedSubtitle: "发如雪", icon: itemIcon1, userInfo: nil)
        let item2 = UIApplicationShortcutItem.init(type: "2", localizedTitle: "test2", localizedSubtitle: "东风破", icon: itemIcon2, userInfo: nil)
        let item3 = UIApplicationShortcutItem.init(type: "3", localizedTitle: "test3", localizedSubtitle: "青花瓷", icon: itemIcon3, userInfo: nil)
        UIApplication.shared.shortcutItems = [item1, item2, item3]
    }

    func application(_: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler _: @escaping (Bool) -> Void) {

        NotificationCenter.default.post(name: NSNotification.Name(touchNameOf3D), object: nil, userInfo: ["name": shortcutItem.localizedTitle])
    }

    func settingUpLog() {
//        let console = ConsoleDestination()
//        log.addDestination(console)

        //        log.verbose("not so important")
        //        log.debug("something to debug")
        //        log.info("a nice information")
        //        log.warning("oh no, that won’t be good")
        //        log.error("ouch, an error did occur!")
        //
        //        log.verbose(123)
        //        log.info(-123.45678)
        //        log.warning(Date())
        //        log.error(["I", "like", "logs!"])
        //        log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])
    }

    func applicationWillResignActive(_: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MyAllSwiftDemos")
        container.loadPersistentStores(completionHandler: { _, error in
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

    func saveContext() {
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
