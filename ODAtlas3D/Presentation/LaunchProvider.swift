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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
        
        
        
        
        
        /*ForEach(apiClient.providers) { provider in
            providerURL = provider.url
            providerPrimaryPalette = provider.primaryPalette
            providerSecondaryPalette = provider.secondaryPalette
            providerDarkPalette = provider.darkPalette
        }*/
        .onAppear {
            //@AppStorage("themePreference") var themePreference: String = "dark"
            //themePreference = "light"
            print("Providers - Launcher page:\(apiClient.providers)")
        }
    }
}

struct LaunchProvider_Previews: PreviewProvider {
    static var previews: some View {
        LaunchProvider()
    }
}
