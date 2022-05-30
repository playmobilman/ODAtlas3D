//
//  Entities.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 19/4/22.
//

import Foundation

struct Provider: Identifiable, Decodable {
    var id: String
    var name: String
    var url: String
    var primaryPalette: String
    var secondaryPalette: String
    var darkPalette: String
}


