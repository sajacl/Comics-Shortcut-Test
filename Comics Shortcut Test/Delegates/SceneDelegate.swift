//
//  SceneDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import UIKit
import SwiftUI

/// Simple wrapper for creating `UIApplicationShortcutItem`.
struct ShortcutItemWrapper {
    let item: ShortcutItem

    func build(with userInfo: [String: NSSecureCoding]? = nil) -> UIApplicationShortcutItem {
        let icon = UIApplicationShortcutIcon(type: .favorite)

        let shortcut = UIApplicationShortcutItem(
            type: ShortcutItem.favorite.type,
            localizedTitle: String(.favorite),
            localizedSubtitle: String(.seeFavoriteList),
            icon: icon,
            userInfo: userInfo
        )

        return shortcut
    }
}

/// List of application `Shortcut`s.
enum ShortcutItem: Equatable {
    /// Favorited comics will appear from this shortcut.
    case favorite

    var type: String {
        switch self {
        case .favorite:
            return "com.personal.comics.favorite"
        }
    }

    var title: String {
        switch self {
        case .favorite:
            return NSLocalizedString(
                "favorite",
                tableName: "Shortcuts",
                value: "Favorite",
                comment: "This title will be mainly used out side of our application, where user holds finger on application icon."
            )
        }
    }

    var subtitle: String {
        switch self {
        case .favorite:
            return NSLocalizedString(
                "seeFavoriteList",
                tableName: "Shortcuts",
                value: "See your favorite list",
                comment: "This subtitle will be mainly used out side of our application, where user holds finger on application icon."
            )
        }
    }

    var icon: UIApplicationShortcutIcon {
        switch self {
        case .favorite:
            return UIApplicationShortcutIcon(type: .favorite)
        }
    }

    // MARK: Equatable

    static func ==(lhs: UIApplicationShortcutItem, rhs: Self) -> Bool {
        lhs.type == rhs.type
    }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { preconditionFailure() }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        checkShortcutItem(connectionOptions.shortcutItem, for: window)

        window.makeKeyAndVisible()
    }

    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        let deferredAction = { (window: UIWindow) in
            if shortcutItem == ShortcutItem.favorite {
                window.rootViewController = UIHostingController(
                    rootView: FavoritesView().environmentObject(ComicEnvironment())
                )

                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }

        if let window = window {
            deferredAction(window)
        } else {
            let window = UIWindow(windowScene: windowScene)
            self.window = window

            deferredAction(window)

            window.makeKeyAndVisible()
        }
    }

    private func checkShortcutItem(
        _ shortcutItem: UIApplicationShortcutItem?,
        for window: UIWindow
    ) {
        let rootViewConstructor: AnyView = {
            if let shortcutItem = shortcutItem, shortcutItem == ShortcutItem.favorite {
                return AnyView(FavoritesView())
            }

            return AnyView(ComicView())
        }()

        window.rootViewController = UIHostingController(
            rootView: rootViewConstructor.environmentObject(ComicEnvironment())
        )
    }
}
