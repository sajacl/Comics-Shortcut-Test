//
//  ThirdPartiesConfiguratorAppDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import MetricKit
import RealmSwift
import UIKit

class ThirdPartiesConfiguratorAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MXMetricManager.shared.add(self)
        setupRealm()
    
        OnlineLog.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/1p0MCcnNcQWV5jI9LoEBiQQ7R2ZiL60_mvhjc_9XNW6A/formResponse", versionField: "entry.2005620554", userInfoField: "entry.1045781291", methodInfoField: "entry.1065046570", textField: "entry.1166974658")
        
        Log.enabled = false
        OnlineLog.enabled = true
        
        return true
    }
    
    fileprivate func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) { }
            })
        
        Realm.Configuration.defaultConfiguration = config
    }
}

extension ThirdPartiesConfiguratorAppDelegate: MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
        guard let firstPayload = payloads.first else { return }
        print(firstPayload.dictionaryRepresentation())
    }
    
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        guard let firstPayload = payloads.first else { return }
        print(firstPayload.dictionaryRepresentation())
    }
}
