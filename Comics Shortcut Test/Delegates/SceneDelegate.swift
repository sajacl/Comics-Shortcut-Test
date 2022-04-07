//
//  SceneDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let persistenceController = PersistenceController.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { preconditionFailure() }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        
        if let shortcutItem = connectionOptions.shortcutItem, shortcutItem.type.contains("favorite") {
            window.rootViewController = UIHostingController(rootView: FavoritesView().environmentObject(ComicEnvironment()))
            
            window.makeKeyAndVisible()
        } else {
            window.rootViewController = UIHostingController(rootView: ComicView().environmentObject(ComicEnvironment()))
            
            window.makeKeyAndVisible()
        }
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        window.rootViewController = UIHostingController(rootView: FavoritesView().environmentObject(ComicEnvironment()))
        window.makeKeyAndVisible()
        
        completionHandler(true)
    }
}
