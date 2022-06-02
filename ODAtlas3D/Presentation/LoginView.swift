//
//  LoginView.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 27/3/22.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: ViewRouter State Object
    @StateObject var viewRouter: ViewRouter
    
    
    //MARK: State Properties
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Welcome!")
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Text("Start scanning and working with patients.")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding()
                
                Divider()
                
                HStack{
                    Button(action: {
                        print("Logging in...")
                        // REDIRECT TO SCAN TYPE SESSION
                        //viewRouter.currentActiveView = .ScanningSessionType
                        //viewRouter.currentActiveView = .ScanningSelection
                        if let NtN_NewPatientURL = URL(string: "http://192.168.1.7:8080") {
                            UIApplication.shared.open(NtN_NewPatientURL)
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                .font(.body)
                            Text("Start now")
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                        }
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
                .padding()
                
                HStack{
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        Text(/*@START_MENU_TOKEN@*/"Sign in to your account"/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                        
                        TextField("Email...", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 6))
                        
                        SecureField("Password...", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 6))
                        
                        Button(action: {
                            print("Logging in...")
                            // REDIRECT TO SCAN TYPE SESSION
                            viewRouter.currentActiveView = .ScanningSessionType
                            //viewRouter.currentActiveView = .ScanningSelection
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    .font(.body)
                                Text("Sign in")
                                    .fontWeight(.medium)
                                    .font(.system(size: 20))
                            }
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                    .hidden()
                    .padding()
                    Spacer()
                }
                
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .padding()
            .background(Image("welcome-fit")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .ignoresSafeArea()
                .blur(radius: 3)
            )
            .mask(
                RadialGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0), Color.white.opacity(1), Color.white.opacity(0)]), center: .center, startRadius: 240, endRadius: 1600)
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewRouter: ViewRouter())
    }
}
