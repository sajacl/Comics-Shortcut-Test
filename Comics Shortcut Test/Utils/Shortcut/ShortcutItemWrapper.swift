//
//  ShortcutItemWrapper.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 2/9/23.
//

import Foundation
import class UIKit.UIApplicationShortcutItem

/// Simple wrapper for creating `UIApplicationShortcutItem`.
struct ShortcutItemWrapper {
    let item: ShortcutItem
    
    static let favoriteShortcut = ShortcutItemWrapper(item: .favorite).build()

    func build(with userInfo: [String: NSSecureCoding]? = nil) -> UIApplicationShortcutItem {
        let shortcut = UIApplicationShortcutItem(
            type: item.type,
            localizedTitle: item.title,
            localizedSubtitle: item.subtitle,
            icon: item.icon,
            userInfo: userInfo
        )

        return shortcut
    }
}
