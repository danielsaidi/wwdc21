//
//  WhatsNewInWatchOS8App.swift
//  WhatsNewInWatchOS8 WatchKit Extension
//
//  Created by Daniel Saidi on 2021-06-09.
//

import SwiftUI

@main
struct WhatsNewInWatchOS8App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
