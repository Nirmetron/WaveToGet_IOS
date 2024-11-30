//
//  ReferralAndRewardsApp.swift
//  ReferralAndRewardsWatchApp WatchKit Extension
//
//  Created by Ismail Gok on 2022-08-27.
//

import SwiftUI

@main
struct ReferralAndRewardsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
