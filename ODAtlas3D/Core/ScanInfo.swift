//
//  ScanInfo.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 30/4/22.
//

import Foundation

struct ScanInfo {
    var refNo:String
    var patientID:String
    
    init(refNo:String, patientID:String) {
        self.refNo = refNo
        self.patientID = patientID
    }
}
