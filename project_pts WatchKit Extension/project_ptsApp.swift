//
//  project_ptsApp.swift
//  project_pts WatchKit Extension
//
//  Created by John Perez on 12/28/21.
//

import SwiftUI

@main
struct project_ptsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
				ContentView()
            }
        }
		
//        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
