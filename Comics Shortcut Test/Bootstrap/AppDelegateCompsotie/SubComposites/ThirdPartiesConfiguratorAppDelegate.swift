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
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

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
