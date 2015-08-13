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

    
    func myRealm() -> Realm {
        let path = "\(NSTemporaryDirectory())hoge.realm"
        return Realm(path: path)
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        myRealm().write {[weak self] in
            self!.myRealm().deleteAll()
        }
        
        let token = myRealm().addNotificationBlock {[weak self] notification, realm in
            println("---notification")
            
            for animal in self!.myRealm().objects(Animal) {
                println(animal.name)
            }
        }
        
        let turtle = Animal()
        turtle.name = "Turtle"
        turtle.legCount = 4
        
        myRealm().write {[weak self] in
            self!.myRealm().add(turtle)
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {[weak self] () -> Void in

            NSThread.sleepForTimeInterval(1)
            
            let crane = Animal()
            crane.name = "Crane"
            crane.legCount = 2
            
            self!.myRealm().write {[weak self] in
                self!.myRealm().add(crane)
            }
            
            self!.myRealm().refresh()
            
            println("---async")
            for animal in self!.myRealm().objects(Animal) {
                println(animal.name)
            }
        })
        
        myRealm().refresh()
        
        println("---sync")
        for animal in myRealm().objects(Animal) {
            println(animal.name)
        }
        
        NSThread.sleepForTimeInterval(2)
        
        myRealm().refresh()
        
        println("---result")
        
        for animal in myRealm().objects(Animal) {
            println(animal.name)
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {[weak self] () -> Void in
            println("---result async")
            for animal in self!.myRealm().objects(Animal) {
                println(animal.name)
            }
        })
        
        myRealm().removeNotification(token)
        
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

