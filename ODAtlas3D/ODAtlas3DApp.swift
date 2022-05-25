//
//  ODAtlas3DApp.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 24/5/22.
//

import SwiftUI

@main
struct ODAtlas3DApp: App {
    var apiClient = HTTPClient()
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView(viewRouter: viewRouter)
            .onOpenURL{ url in
                viewRouter.referenceNo = url.queryParams!["refno"]!
                viewRouter.patientID = url.queryParams!["patientID"]!
                viewRouter.currentActiveView = .ScanningSelection
            }.environmentObject(apiClient)
        }
    }
}
