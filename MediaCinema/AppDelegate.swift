//
//  AppDelegate.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit
import KafkaRefresh
import Network
import FirebaseCore
//import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var realmUtils: RealmUtils!
    var monitor: NWPathMonitor!
    
    static var shared: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            assertionFailure()
            exit(0)
        }
        return delegate
    }
    
    var navigationRootViewController: UINavigationController {
        return window!.rootViewController as! UINavigationController
    }
    
    var appRootViewController: TabbarViewController {
        return (window!.rootViewController as! UINavigationController).viewControllers.first as! TabbarViewController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let navigation = UINavigationController.init(rootViewController: TabbarViewController())
        navigation.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        self.realmUtils = RealmUtilsProvider.defaultStorage
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetConnected"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetLost"), object: nil)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
//        FirebaseApp.configure()
//        AdMobManager.shared.register(key: "RewardAd", type: .rewarded, id: "ca-app-pub-3940256099942544/1712485313")
//        AdMobManager.shared.register(key: "InterstitialAd", type: .interstitial, id: "ca-app-pub-3940256099942544/4411468910")
//        AdMobManager.shared.register(key: "RewardedInterstitialAd", type: .rewardedInterstitial, id: "ca-app-pub-3940256099942544/6978759866")
//        AdMobManager.shared.register(key: "AppOpenAd", type: .appOpen, id: "ca-app-pub-3940256099942544/5662855259")
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if monitor.currentPath.status == .satisfied {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetConnected"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetLost"), object: nil)
        }
//        AdMobManager.shared.show(key: "AppOpenAd")
    }
    
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}



