//
//  ScanningSession.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 15/4/22.
//

import Foundation

//  This will be the main state object which will be managed by the scanning process
public class ScanningSession: ObservableObject {
    @Published var ReferenceNo: String = ""
    @Published var PatientID: String = ""
    @Published var Scans = [FootScan]()
    @Published var IsCompleted: Bool = false
    
    /*init(withRefNo: String, withPatientID: String) {
        self.ReferenceNo = withRefNo
        self.PatientID = withPatientID
    }*/
    
}





/*public class ScanningSession: ObservableObject {
    @Published var scans = [FootScan]()
    var patient: Patient?
    var completed: Bool = false
    var sent: Bool = false
    
    func addScan() {
        let scan = FootScan(dateTaken: Date.now, modelFileURL: "Model.zip", footSide: FootSide.left)
        self.scans.append(scan)
    }
}*/
