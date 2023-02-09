//
//  ShortcutItem.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 2/9/23.
//

import Foundation
import UIKit

/// List of application `Shortcut`s.
enum ShortcutItem: Equatable {
    /// Favorited comics will appear from this shortcut.
    case favorite
    
    init?(type: String) {
        if type == Self.favorite.type {
            self = .favorite
        }
        
        return nil
    }

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
