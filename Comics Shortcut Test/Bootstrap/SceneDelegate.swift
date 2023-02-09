//
//  SceneDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let window: UIWindow
        
        if let windowScene = (scene as? UIWindowScene) {
            window = UIWindow(windowScene: windowScene)
        } else {
            window = UIWindow(frame: .zero)
        }
        
        self.window = window

        let rootView = createRootView(for: window, connectionOptions.shortcutItem)

        window.rootViewController = UIHostingController(
            rootView: rootView
        )

        window.makeKeyAndVisible()
    }

    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        let deferredAction = { (window: UIWindow) in
            window.rootViewController = UIHostingController(
                rootView: self.createRootView(for: window, shortcutItem)
            )
            
            window.makeKeyAndVisible()
        }

        if let window = window {
            deferredAction(window)
        } else {
            let window = UIWindow(windowScene: windowScene)
            self.window = window

            deferredAction(window)
        }
    }

    private func createRootView(
        for window: UIWindow,
        _ shortcutItem: UIApplicationShortcutItem? = nil
    ) -> AnyView {
        if let shortcutItem = shortcutItem,
           shortcutItem.type == ShortcutItem.favorite.type {
            return AnyView(
                FavoritesView()
            )
        }
        
        return AnyView(
            ComicView()
        )
    }
}
