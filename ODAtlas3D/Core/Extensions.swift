//
//  Extensions.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 30/4/22.
//

import Foundation
import SwiftUI

// URL Extension
extension URL {
    var queryParams: [String: String]? {
        guard let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryComponents = urlComponents.queryItems else { return nil }
        return queryComponents.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}

// UIViewController Extension
extension UIViewController {
    /// Add SwiftUI View as child of the input UIView.
    /// Parameters:
    /// -> swiftUIView: The SwiftUI view to be added as a child.
    /// -> view: The UIView instance to which the view will be added.
    func addChildSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Add as child of current ViewController.
        addChild(hostingController)
        
        // Add the SwiftUI view to the controller view hierarchy.
        view.addSubview(hostingController.view)
        
        // Setup AutoLayout constraints to update SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        // Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }
}

// UIColor Extension
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
