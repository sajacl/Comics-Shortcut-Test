//
//  ShortcutHandlerAppDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import UIKit

final class ShortcutHandlerAppDelegate: AppDelegateType {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let favoriteShortcut = ShortcutItemWrapper.favoriteShortcut

        UIApplication.shared.shortcutItems = [
            favoriteShortcut
        ]
        
        return true
    }
}
