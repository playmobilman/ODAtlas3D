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
                apiClient.getUsers(withURL: "https://1229955b-4fc3-4907-9183-79684c64bc90.mock.pstmn.io/users")
            }
        case .ScanningSessionType:
            ScanTypeSelectionView(viewRouter: viewRouter)
        case .ScanningSelection:
            ScanningSelectionView(viewRouter: viewRouter)
        case .Scanning:
            Scanner(viewRouter: viewRouter)
        case .ScanningLeftFoot:
            // Open with left foot info
            Scanner(viewRouter: viewRouter, footSide: FootSide.left)
        case .ScanningRightFoot:
            // Open with right foot info
            Scanner(viewRouter: viewRouter, footSide: FootSide.right)
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
