//
//  ThirdPartiesConfiguratorAppDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import MetricKit
import RealmSwift
import UIKit

final class ThirdPartiesConfiguratorAppDelegate: AppDelegateType, MXMetricManagerSubscriber {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupRealm()
        addApplicationToMetrics()
        
        return true
    }
    
    private func setupRealm() {
        let config = Realm.Configuration(schemaVersion: 1)
        
        Realm.Configuration.defaultConfiguration = config
    }

    private func addApplicationToMetrics() {
        MXMetricManager.shared.add(self)
    }
}

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    init(category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }

    func error<T: Error>(
        error: T,
        message: @autoclosure () -> String? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        var _error = ""

        if let prefixMessage = message() {
            _error = prefixMessage.addLineBreak()
        }

        _error += "{".addLineBreak()
        _error += "\t" + file.addLineBreak()
        _error += "\t" + function.addLineBreak()
        _error += "\t" + String(line).addLineBreak()
        _error += "}".addLineBreak()

        _error += error.localizedDescription

        self.error("\(_error)")
    }
}

private extension String {
    func addLineBreak() -> Self {
        self + "\n"
    }
}
