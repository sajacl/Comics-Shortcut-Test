//
//  PushNotificationsAppDelegate.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import UIKit
import UserNotifications

final class NotificationBuilder {
    /// The time (in seconds) that must elapse from the current time before the trigger fires. This value must be greater than zero.
    private var _timeInterval: () -> UInt = { 0 }

    /// Specify false to deliver the notification one time. Specify true to reschedule the notification request each time the system delivers the notification. If this parameter is true, the value in the timeInterval parameter must be 60 seconds or greater.
    private var _repeats = { false }

    /// An identifier for the notification request.
    private var _identifier = { UUID() }

    /// Text that provides the notification’s primary description.
    private var _title = { String() }

    /// Text that provides the notification’s secondary description.
    private var _subtitle = { String() }

    /// Sound that plays when the system delivers the notification.
    private var _sound = { UNNotificationSound.default }

    /// Custom data to associate with the notification.
    private var _userInfo = { [AnyHashable: Any]() }

    @discardableResult
    func set(timeInterval: @autoclosure @escaping () -> UInt) -> Self {
        _timeInterval = timeInterval

        return self
    }

    @discardableResult
    func set(repeats: @autoclosure @escaping () -> Bool) -> Self {
        _repeats = repeats

        return self
    }

    @discardableResult
    func set(title: @autoclosure @escaping () -> String) -> Self {
        _title = title

        return self
    }

    @discardableResult
    func set(subtitle: @autoclosure @escaping () -> String) -> Self {
        _subtitle = subtitle

        return self
    }

    @discardableResult
    func set(sound: @autoclosure @escaping () -> UNNotificationSound) -> Self {
        _sound = sound

        return self
    }

    @discardableResult
    func set(userInfo: @autoclosure @escaping () -> [AnyHashable: Any]) -> Self {
        _userInfo = userInfo

        return self
    }

    func build() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()

        content.title = _title()
        content.subtitle = _subtitle()
        content.sound = _sound()
        content.userInfo = _userInfo()

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(_timeInterval()),
            repeats: _repeats()
        )

        let request = UNNotificationRequest(
            identifier: _identifier().uuidString,
            content: content,
            trigger: trigger
        )

        return request
    }
}

final class NotificationQueue {
    private let dispatchQueue = DispatchQueue.main
    private let internalQueue = OperationQueue()

    private let notificationCenter: UNUserNotificationCenter

    public typealias CompletionHandler = ((Error?) -> Void)?

    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter

        internalQueue.underlyingQueue = dispatchQueue
    }

    func schedule(request: UNNotificationRequest, completionHandler: CompletionHandler) {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [request.identifier])

        notificationCenter.add(request, withCompletionHandler: completionHandler)
    }

    func schedule(request: NotificationBuilder, completionHandler: CompletionHandler) {
        let request = request.build()

        notificationCenter.removeDeliveredNotifications(withIdentifiers: [request.identifier])
        
        notificationCenter.add(request, withCompletionHandler: completionHandler)
    }
}

final class PushNotificationsAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        requestPushNotificationsAuthorization()

        let nb = NotificationBuilder()

        nb.set(sound: .defaultCritical)
            .set(repeats: true)
            .set(subtitle: "")
            .set(userInfo: ["Hi": 1])

        return true
    }
    
    public static func sendLocalPushNotification(title: String, subtitle: String, object: Any? = nil, afterInterval: TimeInterval = 3) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        
        if let object = object {
            content.userInfo = ["result": object]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: afterInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        LInfo("APNs token retrieved: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {}

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        LInfo("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func requestPushNotificationsAuthorization() {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {}
}

// MARK: UNUserNotificationCenterDelegate

extension PushNotificationsAppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
