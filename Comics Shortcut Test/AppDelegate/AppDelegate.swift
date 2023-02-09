//
//  AppDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import UIKit
import CoreData
import RealmSwift

typealias AppDelegateType = UIResponder & UIApplicationDelegate

@main
final class AppDelegate: AppDelegateType {
    /// Default app delegates/configurations factory.
    private let appDelegate = AppDelegateFactory.default()

    /// Default configuration name for `UIScene`.
    private let defaultSceneName = "Default Configuration"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let didFinishLaunching = appDelegate.application?(
            application,
            didFinishLaunchingWithOptions: launchOptions
        ) {
            return didFinishLaunching
        }

        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: defaultSceneName,
            sessionRole: connectingSceneSession.role
        )
    }
}
