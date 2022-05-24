//
//  Scanner.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 3/4/22.
//

import SwiftUI

struct Scanner: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var footSide: FootSide?
    
    var body: some View {
        ScannerView(footSide: footSide)
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
