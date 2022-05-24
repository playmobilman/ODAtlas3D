//
//  ScanningSelectionView.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 27/3/22.
//

import SwiftUI

struct ScanningSelectionView: View {
    
    // Main navigation state object router
    @ObservedObject var viewRouter: ViewRouter
    
    // Main state object that the app will be watching during scanning process
    // It´ll be initialized with URL Scheme parameters corresponding to ReferenceNo. and PatientID
    // Check previous existence of this object
    @ObservedObject var scanningSession = ScanningSession()
    
    var body: some View {
        ZStack {
            Color("Background").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                Text("This scanning session")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                Text("Reference no.: \(scanningSession.ReferenceNo)")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                Text("Patient ID: \(scanningSession.PatientID)")
                    .font(.system(size: 25))
                    .foregroundColor(.blue)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                Text("Ready to scan")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                Text("Select at least one foot to continue")
                    .font(.body)
                    .foregroundColor(.blue)
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                HStack {
                    VStack{
                        Button("Start scanning") {
                            openScanSession()
                        }
                        .buttonStyle(MainButton())
                    }
                    
                    /*VStack{
                        Button(action: {
                            // Open dedicated scan session view for each foot.
                            openScanSession(footSide: FootSide.left)
                        }) {
                            HStack {
                                Image(systemName: "viewfinder")
                                    .font(.system(size: 30))
                                Text("Scan\nLeft Foot")
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
                    VStack{
                        Button(action: {
                            // Open dedicated scan session view for each foot.
                            openScanSession(footSide: FootSide.right)
                        }) {
                            HStack {
                                Image(systemName: "viewfinder")
                                    .font(.system(size: 30))
                                Text("Scan\nRight Foot")
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
                    }*/
                }.padding()
                
                if(scanningSession.Scans.count > 0) {
                    
                } else {
                    Text("No scans")
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                if(scanningSession.Scans.count > 0) {
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            HStack {
                                Image(systemName: "chevron.right.circle")
                                    .font(.title)
                                Text("Continue")
                                    .fontWeight(.medium)
                                    .font(.system(size: 25))
                            }
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .frame(minWidth: 0, maxWidth: 640, minHeight: 0, maxHeight: 640, alignment: .topLeading)
            .padding(.horizontal)
            .onAppear(perform: {
                scanningSession.ReferenceNo = self.viewRouter.referenceNo
                scanningSession.PatientID = self.viewRouter.patientID
            })
        }
    }
    
    func openScanSession() -> Void {
        viewRouter.currentActiveView = .Scanning
    }
    
    func openScanSession(footSide: FootSide) -> Void {
        switch footSide {
        case .left:
            viewRouter.currentActiveView = .ScanningLeftFoot
        case .right:
            viewRouter.currentActiveView = .ScanningRightFoot
        }
    }
}

struct ScanningSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                ScanningSelectionView(viewRouter: ViewRouter())
                .environment(\.colorScheme, .dark)
            
        }
        ScanningSelectionView(viewRouter: ViewRouter())
    }
}
