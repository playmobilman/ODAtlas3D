//
//  MainButton.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 26/3/22.
//

import Foundation
import SwiftUI

struct MainButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        let blueFirstShade = Color(red: 7/255, green: 35/255, blue: 148/255)
        let blueSecondShade = Color(red: 57/255, green: 125/255, blue: 186/255)
        let linearGradient = Gradient(colors: [blueSecondShade, blueFirstShade])
        let linearGradientPressed = Gradient(colors: [blueFirstShade, blueSecondShade])
        
        
        configuration.label
            .padding()
            .background(
                LinearGradient(
                    gradient: !configuration.isPressed ? linearGradient : linearGradientPressed,
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .foregroundColor(!configuration.isPressed ? .white : .black)
            .cornerRadius(12)
            .clipShape(Capsule())
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
