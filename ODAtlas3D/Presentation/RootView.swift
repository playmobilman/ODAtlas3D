//
//  RootView.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 27/3/22.
//

import SwiftUI

struct RootView: View {
    // HTTPClient object attached to environment for global access
    @EnvironmentObject var apiClient: HTTPClient
    @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        switch viewRouter.currentActiveView {
        case .Login:
            Welcome(viewRouter: viewRouter).onAppear(){
                // Go get branding provider URLs
                apiClient.getAppServiceProviders(withURL: "http://192.168.68.103:8000")
            }
        case .ScanningSessionType:
            ScanTypeSelectionView(viewRouter: viewRouter)
        case .ScanningSelection:
            ScanningSelectionView(viewRouter: viewRouter).onAppear(){
                apiClient.getAppServiceProviders(withURL: "http://192.168.68.103:8000")
            }
        case .Scanning:
            Scanner(viewRouter: viewRouter)
        case .ScanningLeftFoot:
            // Open with left foot info
            Scanner(viewRouter: viewRouter, footSide: FootSide.left)
        case .ScanningRightFoot:
            // Open with right foot info
            Scanner(viewRouter: viewRouter, footSide: FootSide.right)
        case .Launcher:
            // Open launcher view
            LaunchProvider()
        default:
            Scanner(viewRouter: viewRouter)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewRouter: ViewRouter()).environmentObject(HTTPClient())
    }
}
