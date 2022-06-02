//
//  LaunchProvider.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 29/5/22.
//

import SwiftUI

struct LaunchProvider: View {
    // HTTPClient object attached to environment for global access
    @EnvironmentObject var apiClient: HTTPClient
    //@EnvironmentObject var appTheme: AppTheme
    
    var body: some View {
        let providers: [Provider] = apiClient.providers
        /*ForEach(providers, id: \.id) { provider in
            appTheme.providerPrimaryColor = Color(provider.primaryPalette)
        }*/
        
        HStack{
            LauncherProviderButtons(providers: apiClient.providers)
            
            
            
            /*if(apiClient.providers.count > 0) {
                ForEach(apiClient.providers) { provider in
                    self.appTheme.providerPrimaryColor = Color(provider.primaryPalette)
                    Button(provider.name) {
                        print("Logging in...")
                        // REDIRECT TO SCAN TYPE SESSION
                        //viewRouter.currentActiveView = .ScanningSessionType
                        //viewRouter.currentActiveView = .ScanningSelection
                        if let NtN_NewPatientURL = URL(string: "http://192.168.1.7:8080") {
                            UIApplication.shared.open(NtN_NewPatientURL)
                        }
                    }   
                    .buttonStyle(MainButton())
                    .background
                }
            } else {
                VStack(spacing:20) {
                    Text("There are not available providers at the moment.")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding()
                }
                .padding()
            }*/
        }
    }
}

struct LaunchProvider_Previews: PreviewProvider {
    static var previews: some View {
        LaunchProvider()
    }
}
