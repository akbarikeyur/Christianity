//
//  AppDelegate.swift
//  Christianity
//
//  Created by PC on 21/06/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView
import MFSideMenu
import MediaPlayer
import Firebase
import UserNotifications
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!
    var container : MFSideMenuContainerViewController = MFSideMenuContainerViewController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
     
        if isUserLogin() {
            AppModel.shared.currentUser = UserModel.init(dict: getLoginUserData()!)
            navigateToDashBoard()
        }
        
        if getDefaultLanguage() != "" {
            if getDefaultLanguage() == "en" {

            } else {

            }
        }
        else {
            setDefaultLanguage("en")
        }

        bundle = LanguageManager.sharedInstance.getCurrentBundle()
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        //Push Notification
        registerPushNotification(application)
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        return true
    }
    
    /**
     * UIStoryboard
     *
     * Used to access main storyboard instance
     *
     * @param
     */
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    
    /**
     * AppDelegate Sharing
     *
     * Used to share AppDelegate method to access globally
     *
     * @param
     */
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /**
     * Show loader till sending/getting data to/from server
     *
     * Set color and size here
     *
     * @param
     */
    func showLoader()
    {
        removeLoader()
        window?.isUserInteractionEnabled = false
        activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
        activityLoader.type = .ballSpinFadeLoader
        activityLoader.color = AppColor
        window?.addSubview(activityLoader)
        activityLoader.startAnimating()
    }
    
    /**
     * Hide loader after getting response from server
     *
     * @param
     */
    func removeLoader()
    {
        window?.isUserInteractionEnabled = true
        if activityLoader == nil
        {
            return
        }
        activityLoader.stopAnimating()
        activityLoader.removeFromSuperview()
        activityLoader = nil
    }
    
    func logout() {
        AppModel.shared.currentUser = nil
        removeUserDefaultValues()
        AppModel.shared.resetAllModel()
        navigateToLogin()
    }
    
    func navigateToLogin(){
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ViewControllerNavigation") as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = navigationVC
    }
    
    
    func navigateToDashBoard()
    {
        let rootVC: MFSideMenuContainerViewController = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MFSideMenuContainerViewController") as! MFSideMenuContainerViewController
        container = rootVC
        var navController: UINavigationController = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "DashboardVCNav") as! UINavigationController
        if #available(iOS 9.0, *) {
            let vc : HomeVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            
            let leftSideMenuVC: UIViewController = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SideMenuVC")
            container.menuWidth = UIDevice.current.userInterfaceIdiom == .pad ? 400 : 290
            //container.menuWidth = 290
            container.panMode = MFSideMenuPanModeSideMenu
            container.menuSlideAnimationEnabled = false
            container.leftMenuViewController = leftSideMenuVC
            container.centerViewController = navController
            
            container.view.layer.masksToBounds = false
            container.view.layer.shadowOffset = CGSize(width: 10, height: 10)
            container.view.layer.shadowOpacity = 0.5
            container.view.layer.shadowRadius = 5
            container.view.layer.shadowColor = UIColor.clear.cgColor
            
            let rootNavigatioVC : UINavigationController = self.window?.rootViewController
                as! UINavigationController
            rootNavigatioVC.pushViewController(container, animated: false)
        }
    }

    
    override func remoteControlReceived(with event: UIEvent?) {
        if let receivedEvent = event {
            if (receivedEvent.type == .remoteControl) {
                switch receivedEvent.subtype {
                case .remoteControlTogglePlayPause:
                    if MusicHandle.shared.player.rate == 0.0 {
                        MusicHandle.shared.PlayMusic(MusicHandle.shared.selectedTrack.link)
                    }else{
                        MusicHandle.shared.pauseMusic()
                    }
                    break
                case .remoteControlPlay:
                    MusicHandle.shared.PlayMusic(MusicHandle.shared.selectedTrack.link)
                    break
                case .remoteControlPause:
                    MusicHandle.shared.pauseMusic()
                    break
                default:
                    print("received sub type \(receivedEvent.subtype) Ignoring")
                }
            }
        }
    }
    
    //MARK:- Notification
    func registerPushNotification(_ application: UIApplication)
    {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo["gcmMessageIDKey"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        
        if let messageID = userInfo["gcmMessageIDKey"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        if getPushToken() == ""
        {
            setPushToken(fcmToken)
            print(fcmToken)
        }
    }
    
    
    func getFCMToken() -> String
    {
        return Messaging.messaging().fcmToken!
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


extension String {
    func localizedStr(language : String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundleName = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundleName!, value: "", comment: "")
    }
}

/**
 * Get Top View Control
 *
 * Find the top view controller from queue and return it.
 * It's used in global function whenever need active View controller
 *
 * @param
 */
extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


//extension AppDelegate : MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        //print("Firebase registration token: \(fcmToken)")
//        if getPushToken() == ""
//        {
//            setPushToken(fcmToken)
//            print(fcmToken)
//        }
//    }
//
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        //print("Received data message: \(remoteMessage.appData)")
//    }
//}

// MARK:- Push Notification
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        _ = notification.request.content.userInfo
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if UIApplication.shared.applicationState == .inactive
        {
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(delayForNotification(tempTimer:)), userInfo: userInfo, repeats: false)
        }
        else
        {
            notificationHandler(userInfo as! [String : Any])
        }
        
        completionHandler()
    }
    
    @objc func delayForNotification(tempTimer:Timer)
    {
        notificationHandler(tempTimer.userInfo as! [String : Any])
    }
    
    //Redirect to screen
    func notificationHandler(_ dict : [String : Any])
    {
        navigateToDashBoard()
    }
}
