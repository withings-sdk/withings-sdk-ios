//
//  AppDelegate.swift
//  SdkSampleApp
//
//  Created by Withings on 27/02/2020.
//  Copyright © 2020 Withings. All rights reserved.
//

import UIKit
import Withings

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainNavController")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        startBackgroundSync()
        return true
    }

    // MARK: - Background sync
    
    func restartBackgroundSync() {
        WithingsBackgroundSyncManager.start(with: ["YOUR-DEVICE-KEY"])
    }
    
    private func startBackgroundSync() {
        NotificationCenter.default.addObserver(forName: WithingsBackgroundSyncStatus.notificationName, object: nil, queue: nil) { [weak self] (notification) in
            guard let status = notification.userInfo?[WithingsBackgroundSyncStatus.notificationStatusKey] as? WithingsBackgroundSyncStatus else { return }
            self?.logSyncStatus(status)
        }
        restartBackgroundSync()
    }
    
    private func logSyncStatus(_ status: WithingsBackgroundSyncStatus) {
        let title = "Background sync status"
        let message: String
        switch status {
        case .started(let deviceId):
            message = "Sync started for \(deviceId)"
        case .succeeded(let deviceId):
            message = "Sync succeeded for \(deviceId)"
        case .failed(let deviceId):
            message = "Sync failed for \(deviceId)"
        }
        print("\(title) -- \(message)")
    }

}

