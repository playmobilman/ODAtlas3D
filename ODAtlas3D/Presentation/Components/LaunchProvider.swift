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
    
    var body: some View {
        HStack{
            if(apiClient.providers.count > 0) {
                ForEach(apiClient.providers) { provider in
                    Button(action: {
                        print("Logging in...")
                        // REDIRECT TO SCAN TYPE SESSION
                        //viewRouter.currentActiveView = .ScanningSessionType
                        //viewRouter.currentActiveView = .ScanningSelection
                        if let NtN_NewPatientURL = URL(string: "http://192.168.68.103:8080") {
                            UIApplication.shared.open(NtN_NewPatientURL)
                        }
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up.on.square")
                                .font(.body)
                            Text(provider.name)
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                        }
                    }.buttonStyle(MainButton())
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
            }
        }
        
        
        /*VStack(spacing: 20) {
            HStack(alignment: .center, spacing: 10){
                ForEach(apiClient.providers) { provider in
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "rectangle.grid.1x2.fill")
                            Text(provider.name)
                        }
                        .padding()
                        .background(Color.yellow)
                    }
                }
            }
            .frame(width: 340, height: 220, alignment: .center)
            .padding()
            .cornerRadius(10)
            .shadow(radius: 20)
        }
        .onAppear {
            //@AppStorage("themePreference") var themePreference: String = "dark"
            //themePreference = "light"
            print("Providers - Launcher page:\(apiClient.providers)")
        }*/
    }
}

struct LaunchProvider_Previews: PreviewProvider {
    static var previews: some View {
        LaunchProvider()
    }
}
