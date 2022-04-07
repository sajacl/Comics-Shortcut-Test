//
//  AppDelegateFactory.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import Foundation

enum AppDelegateFactory {
    static func `default`() -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [PushNotificationsAppDelegate(), ThirdPartiesConfiguratorAppDelegate(), ShortcutHandlerAppDelegate()])
    }
}
