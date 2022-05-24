//
//  ViewRouter.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 27/3/22.
//

import SwiftUI
class ViewRouter: ObservableObject {
    @Published var currentActiveView: ActiveView = .Login
    @Published var referenceNo:String = ""
    @Published var patientID:String = ""
}
