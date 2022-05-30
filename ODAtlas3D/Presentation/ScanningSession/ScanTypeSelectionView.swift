//
//  ScanTypeSelectionView.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 1/5/22.
//

import SwiftUI

struct ScanTypeSelectionView: View {
    // Main navigation state object router
    @ObservedObject var viewRouter: ViewRouter
    
    // Main state object that the app will be watching during scanning process
    // It´ll be initialized with URL Scheme parameters corresponding to ReferenceNo. and PatientID
    // Check previous existence of this object
    @ObservedObject var scanningSession = ScanningSession()
    
    var body: some View {
        HStack{
            Text("Please, select scanning mode")
                .font(.system(size: 25))
                .foregroundColor(.blue)
                .frame(width: 350)
                .multilineTextAlignment(.center)
        }.padding()
        HStack {
            VStack {
                Button(action: {
                    print("New patient processing...")
                    if let NtN_NewPatientURL = URL(string: "http://192.168.68.103:8080") {
                        UIApplication.shared.open(NtN_NewPatientURL)
                    }
                }) {
                    HStack {
                        Image(systemName: "person.fill.badge.plus")
                            .font(.system(size: 30))
                        Text("New Patient\nScan")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                    }
                    .padding([.leading, .trailing], 25)
                    .padding([.top, .bottom], 20)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(5)
                }
            }
            VStack {
                Button(action: {
                    print("Existing patient processing...")
                    if let NtN_NewPatientURL = URL(string: "http://192.168.68.103:8080") {
                        UIApplication.shared.open(NtN_NewPatientURL)
                    }
                }) {
                    HStack {
                        Image(systemName: "person.badge.clock.fill")
                            .font(.system(size: 30))
                        Text("Existing Patient\nScan")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                    }
                    .padding([.leading, .trailing], 25)
                    .padding([.top, .bottom], 20)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                }
            }
        }.padding()
        HStack {
            Text("In both cases, you will be taken to OrthoticsDirect´s Nav-to-Net system for process completion.")
                .font(.system(size: 15))
                .foregroundColor(.white)
                .italic()
                .frame(width: 450)
                .multilineTextAlignment(.center)
        }
    }
}

struct ScanTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ScanTypeSelectionView(viewRouter: ViewRouter())
    }
}
