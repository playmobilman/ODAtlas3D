//
//  ODAtlas3DApp.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 24/5/22.
//

import SwiftUI

@main
struct ODAtlas3DApp: App {
    @StateObject var viewRouter = ViewRouter()
    var apiClient = HTTPClient()
    
    var body: some Scene {
        WindowGroup {
            RootView(viewRouter: viewRouter)
            .onOpenURL{ url in
                viewRouter.referenceNo = url.queryParams!["refno"]!
                viewRouter.patientID = url.queryParams!["patientID"]!
                // Current view ScanningSelection
                viewRouter.currentActiveView = .ScanningSelection
                //viewRouter.currentActiveView = .Launcher
            }.environmentObject(apiClient)
        }
    }
}
