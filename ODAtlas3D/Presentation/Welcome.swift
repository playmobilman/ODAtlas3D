//
//  Welcome.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 26/3/22.
//

import SwiftUI

struct Welcome: View {
    
    //MARK: ViewRouter State Object
    @StateObject var viewRouter: ViewRouter
    
    //MARK: HTTPClient object attached to environment for global access
    //@EnvironmentObject var apiClient: HTTPClient
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Welcome!")
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Text("Please select a provider to start scanning and working with patients.")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding()
                
                Divider()
                
                Text("Available providers")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding()
                
                /*HStack{
                    ForEach(apiClient.providers) { provider in
                        Button(action: {
                            print("Logging in...")
                            // REDIRECT TO SCAN TYPE SESSION
                            //viewRouter.currentActiveView = .ScanningSessionType
                            //viewRouter.currentActiveView = .ScanningSelection
                            if let NtN_NewPatientURL = URL(string: "http://192.168.68.104:8080") {
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
                }*/
                LaunchProvider()
                .padding()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .padding()
            .background(Image("AtlasWelcome")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .ignoresSafeArea()
                .blur(radius: 1.5)
            )
            .mask(
                RadialGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0), Color.white.opacity(1), Color.white.opacity(0)]), center: .center, startRadius: 240, endRadius: 1600)
            )
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome(viewRouter: ViewRouter())
    }
}
