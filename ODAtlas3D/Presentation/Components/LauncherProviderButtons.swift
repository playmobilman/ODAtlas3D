//
//  LauncherProviderButtons.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 2/6/22.
//

import SwiftUI
import DynamicColor

struct LauncherProviderButtons: View {
    @EnvironmentObject var appTheme: AppTheme
    var providers:[Provider]
    
    var body: some View {
        if(providers.count > 0) {
            HStack {
                ForEach(providers) { prov in
                    Button {
                        self.appTheme.providerPrimaryColor = UIColor.init(hexString: prov.primaryPalette)
                        self.appTheme.providerSecondaryColor = UIColor.init(hexString: prov.primaryPalette)
                        // REDIRECT TO SCAN TYPE SESSION
                        //viewRouter.currentActiveView = .ScanningSessionType
                        //viewRouter.currentActiveView = .ScanningSelection
                        if let NtN_NewPatientURL = URL(string: "http://192.168.68.104:8080") {
                            UIApplication.shared.open(NtN_NewPatientURL)
                        }
                    } label: {
                        Text(prov.name).padding(20)
                    }
                    .buttonStyle(MainButton())
                }
            }
        }
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
