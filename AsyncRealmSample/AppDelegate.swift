//
//  AppDelegate.swift
//  AsyncRealmSample
//
//  Created by haranicle on 2015/07/25.
//  Copyright (c) 2015年 haranicle. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let realm = Realm()
        
        realm.write {
            realm.deleteAll()
        }
        
        let turtle = Animal()
        turtle.name = "Turtle"
        turtle.legCount = 4
        
        realm.write {
            realm.add(turtle)
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
            let realm = Realm()
            let crane = Animal()
            crane.name = "Crane"
            crane.legCount = 2
            
            Realm().write {
                NSThread.sleepForTimeInterval(1)
                Realm().add(crane)
                println("---added")
                let animals2 = Realm().objects(Animal)
                for animal in animals2 {
                    println(animal.name)
                }
            }
        })
        
        let animals1 = Realm().objects(Animal)
        
        for animal in animals1 {
            println(animal.name)
        }
        
        NSThread.sleepForTimeInterval(2)
        
        println("---result")
        
        let animals3 = Realm().objects(Animal)
        for animal in animals3 {
            println(animal.name)
        }
        

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

