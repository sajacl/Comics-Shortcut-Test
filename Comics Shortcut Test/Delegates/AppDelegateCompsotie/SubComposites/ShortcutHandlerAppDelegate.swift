//
//  ShortcutHandlerAppDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import UIKit

class ShortcutHandlerAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let icon = UIApplicationShortcutIcon(type: .favorite)
        let item = UIApplicationShortcutItem(type: "com.personal.comics.favorite", localizedTitle: String(.favorite), localizedSubtitle: String(.seeFavoriteList), icon: icon, userInfo: nil)
        UIApplication.shared.shortcutItems = [item]
        
        return true
    }
}
