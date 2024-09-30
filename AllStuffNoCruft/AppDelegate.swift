//
//  AppDelegate.swift
//  AllStuffNoCruft
//
//  Created by 한현규 on 9/10/24.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseMessaging
import LogUtil


class AppDelegate: NSObject, UIApplicationDelegate {

      
   func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       UNUserNotificationCenter.current().delegate = self
       return true
   }

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       FirebaseApp.configure()            
       
       Messaging.messaging().delegate = self
       
       LogSetup.setupLogger()
       
       let authOptions : UNAuthorizationOptions = [.alert , .badge , .sound]
       UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
           print("NOTIFICATION ERROR : \(error.debugDescription)")
       }
       application.registerForRemoteNotifications()
       
       return true
   }

    
}


//MARK: Notoficatio handler
extension AppDelegate : UNUserNotificationCenterDelegate{
   
    
    //The method will be called on the delegate only if the application is in the foreground
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       completionHandler([.list , .banner , .badge , .sound])
       let userInfo = notification.request.content.userInfo
       print("Message WillPresent: \(userInfo)")
   }
               
    //The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction
   func userNotificationCenter(
     _ center: UNUserNotificationCenter,
     didReceive response: UNNotificationResponse,
     withCompletionHandler completionHandler: @escaping () -> Void
   ) {
     if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
         let userInfo = response.notification.request.content.userInfo
         print("Message Tap: \(userInfo)")
     }
     
     if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
         print("System push dismiss")
     }
   }
    
    // For SwiftUI
    // This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
   
}

//MARK: FCM token update
extension AppDelegate : MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        //TODO: fcmToken update
    }

}
