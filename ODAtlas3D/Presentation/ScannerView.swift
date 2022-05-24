//
//  ScannerView.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 2/4/22.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    var footSide: FootSide?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> MainViewController {
        let storyboard = UIStoryboard(name: "ScanStoryboard", bundle: Bundle.main)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "ScannerMainSb") as! MainViewController
        
        //mainVC.footSide = self.footSide!
        
        return mainVC
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context:Context) {}
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
