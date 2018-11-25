//
//  AppDelegate.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/24.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // acf_did
//        var cookieProperties = [HTTPCookiePropertyKey: String]()
//        cookieProperties[HTTPCookiePropertyKey.name] = "acf_did" as String
//        cookieProperties[HTTPCookiePropertyKey.value] = "6412f66c83a322e90fa3307d00001521" as String
//        
//        let cookie = HTTPCookie(properties: cookieProperties)
//        HTTPCookieStorage.shared.setCookie(cookie!)
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let root = ZJTabBarController()
        self.window?.rootViewController = root
        UIApplication.shared.statusBarStyle = .lightContent
        
        if let cookieArray = UserDefaults.standard.array(forKey: ZJ_DOUYU_TOKEN) {
            for cookieData in cookieArray {
                if let dict = cookieData as? [HTTPCookiePropertyKey : Any] {
                    if let cookie = HTTPCookie.init(properties : dict) {
                        HTTPCookieStorage.shared.setCookie(cookie)
                    }
                }
            }
        }
//        getDouYuConfig()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func getDouYuConfig() {
//        let dict : [String : String] = ["client_sys" : "ios"]
        ZJNetWorking .requestData(type: .GET, URlString: ZJDouYuConfig, parameters: nil) { (response) in
            
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

