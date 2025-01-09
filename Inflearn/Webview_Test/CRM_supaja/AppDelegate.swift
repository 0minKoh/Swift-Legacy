//
//  AppDelegate.swift
//  Webview_Test
//
//  Created by supaja on 2023/01/01.
//

import UIKit
import OneSignal
import WebKit

protocol AppDelegateDelegate: ViewController {
    func didReceiveUrlString(urlString: String)
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    weak var delegate: AppDelegateDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
          
          // OneSignal initialization
          OneSignal.initWithLaunchOptions(launchOptions)
          OneSignal.setAppId("63347aac-4ff1-4819-878f-36ff12512dd4")
        OneSignal.promptForPushNotifications(userResponse: {accepted in print("User accepted notifications: \(accepted)")})
        OneSignal.sendTag("first_session", value: "true")
        
        // eventHandling notification
        let notificationOpenedBlock: OSNotificationOpenedBlock = { result in
            let notification: OSNotification = result.notification
            if let additionalData = notification.additionalData, let urlString = additionalData["url"] as? String {
                self.delegate?.didReceiveUrlString(urlString: urlString)
            }
        }
        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
        return true
    }

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
    
    


}

