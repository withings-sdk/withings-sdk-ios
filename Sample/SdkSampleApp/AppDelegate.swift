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
        WithingsSyncManager.start(with: ["YOUR-DEVICE-KEY"])
    }
    
    private func startBackgroundSync() {
        NotificationCenter.default.addObserver(forName: WithingsSyncStatus.notificationName, object: nil, queue: nil) { [weak self] (notification) in
            guard let status = notification.userInfo?[WithingsSyncStatus.notificationStatusKey] as? WithingsSyncStatus else { return }
            self?.logSyncStatus(status)
        }
        restartBackgroundSync()
    }
    
    private func logSyncStatus(_ status: WithingsSyncStatus) {
        let title = "Background sync status"
        let message: String
        switch status {
        case .started(let peripheral):
            message = "Sync started for \(peripheral.name ?? peripheral.deviceKey)"
        case .succeeded(let peripheral):
            message = "Sync succeeded for \(peripheral.name ?? peripheral.deviceKey)"
        case .failed(let peripheral):
            message = "Sync failed for \(peripheral.name ?? peripheral.deviceKey)"
        @unknown default:
            message = "\(status)"
        }
        print("\(title) -- \(message)")
    }

}

