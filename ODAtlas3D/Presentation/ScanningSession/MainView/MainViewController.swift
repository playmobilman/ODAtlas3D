//
//  ViewController.swift
//  SwiftScanner
//
//  Created by Windmolders Joris on 02/06/2020.
//  Copyright © 2020 CoderJoris. All rights reserved.
//

import UIKit
import os.log
import SwiftUI

class MainViewController: UIViewController, ScanBufferDelegate, ScanningTriggerDelegate {
    
    // FootSide scanned at the moment
    var footSide = FootSide.left
    
    // Add sub-view (EXPERIMENT)
    var scanSelectionView = ScanSessionStatus() //ScanningSelectionView(viewRouter: ViewRouter())
    

    // Reference to the observable object Scanning Session store to update SwiftUI views
    //var scanningSession: ScanningSession!
    
    fileprivate var meshes = [STMesh]()
    fileprivate var files = [String]()
    
    @IBOutlet weak var scanMessageLabel: UILabel!
    @IBOutlet weak var batteryStatusControl: BatteryStatusUIStackView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var deleteScansButton: UIButton!
    @IBOutlet weak var portalStatusHostingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // EXPERIMENT
        scanSelectionView.delegate = self
        addSwiftUIStateView()
        self.scanMessageLabel?.text = "No scans taken yet"
        self.sendButton?.layer.cornerRadius = 10
        self.deleteScansButton?.layer.cornerRadius = 10
        self.sendButton?.isHidden = true
        self.deleteScansButton?.isHidden = true
        self.batteryStatusControl?.start()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillTerminate(notification:)),
                                               name: UIApplication.willTerminateNotification,
                                               object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillTerminate(notification:)),
                                               name: UIApplication.willTerminateNotification,
                                               object: nil)
    }
    
    @objc func applicationWillTerminate(notification: Notification) {
        deleteAllFiles()
    }
    
    // Add sub-view (EXPERIMENT)
    func addSwiftUIStateView() {
        addChildSwiftUIView(scanSelectionView, to: portalStatusHostingView)
    }
    
    func runLeftScan() {
        self.footSide = FootSide.left
        performSegue(withIdentifier: "NewScanSegue", sender: nil)
    }
    
    func runRightScan() {
        self.footSide = FootSide.right
        performSegue(withIdentifier: "NewScanSegue", sender: nil)
    }
    
    /*func addSwiftUIView() {
        let swiftUIView = ScanningSelectionView(viewRouter: ViewRouter())
        let hostingController = UIHostingController(rootView: swiftUIView)

        /// Add as a child of the current view controller.
        addChild(hostingController)

        /// Add the SwiftUI view to the view controller view hierarchy.
        view.addSubview(hostingController.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        /// Notify the hosting controller that it has been moved to the current view controller.
        hostingController.didMove(toParent: self)
    }*/
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Navigation
    @IBAction func unwindToMainView(segue: UIStoryboardSegue) {
        self.batteryStatusControl.start()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "NewScanSegue":
            os_log("Preparing for NewScanSegue", log: OSLog.application, type: .debug)
            guard let scanViewController = segue.destination as? ScanViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            self.batteryStatusControl.stop()
            scanViewController.scanBuffer = self
            scanViewController.footSide = self.footSide
        default:
            return
        }
    }
    
    //MARK: ScanBufferDelegate
    func addScan(_ mesh: STMesh)
    {
        // (In-memory) Here we would have to save to LocalDB
        self.meshes.append(mesh)
        
        self.sendButton.isHidden = self.meshes.count < 1
        self.deleteScansButton.isHidden = self.meshes.count < 1
        let messageStringFormat = "Collected \(self.meshes.count) scans"
        let message = String.init(format: messageStringFormat, self.meshes.count)
        self.scanMessageLabel.text = message
    }
    
    //MARK: - UI Callbacks
    @IBAction func addLeftScan(_ sender: Any) {
        self.footSide = FootSide.left
        performSegue(withIdentifier: "NewScanSegue", sender: nil)
    }
    
    @IBAction func addRightScan(_ sender: Any) {
        self.footSide = FootSide.right
        performSegue(withIdentifier: "NewScanSegue", sender: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        sender.layer.cornerRadius = 10
        self.batteryStatusControl.stop()
        
        var fileURLs = [Any]()
        for (index, mesh) in self.meshes.enumerated() {
            let fileName = String.init(format: "SCAN-MODEL%03d.ZIP", index)
            guard let fileResult = saveMesh(mesh: mesh, fileName: fileName) else {
                os_log(.error, log: OSLog.application, "Error creating file: %{Public}@", fileName)
                continue
            }
            
            fileURLs.append(fileResult.fileURL)
            self.files.append(fileResult.filePath)
        }
        
        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: fileURLs, applicationActivities: nil)
        
        // Show popover with arrow pointing to the right
        activityViewController.popoverPresentationController?.sourceView = (self.sendButton!)
        activityViewController.popoverPresentationController?.sourceRect = self.sendButton!.bounds
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.openInIBooks,
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.markupAsPDF
        ]
        
        // Show the share-view
        self.present(activityViewController, animated: true, completion: { () in
            self.batteryStatusControl.start()
        })
    }
    
    @IBAction func deleteScansButtonPressed(_ sender: UIButton) {
        self.sendButton.isHidden = true
        
        deleteAllFiles()
        
        self.files.removeAll()
        self.meshes.removeAll()
        self.scanMessageLabel.text = "No scans taken yet"
        self.deleteScansButton.isHidden = true
    }
    
    private func deleteAllFiles() {
        for filePath in self.files {
            do {
                if FileManager.default.fileExists(atPath: filePath)
                {
                    try FileManager.default.removeItem(atPath: filePath)
                    os_log(.debug, log: OSLog.application, "Deleted file: %{Public}@", filePath)
                }
            }
            catch {
                os_log(.error, log: OSLog.application, "Error deleting mesh: %{Public}@", error.localizedDescription)
            }
        }
    }
    
    private func saveMesh(mesh: STMesh, fileName : String) -> (filePath: String, fileURL: NSURL)? {
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            if FileManager.default.fileExists(atPath: filePath)
            {
                try FileManager.default.removeItem(atPath: filePath)
            }
            
            let options: [AnyHashable: Any] = [ kSTMeshWriteOptionFileFormatKey : STMeshWriteOptionFileFormat.objFileZip.rawValue]
            try mesh.write(toFile: filePath, options: options)
            return (filePath, NSURL(fileURLWithPath: filePath))
        }
        catch {
            os_log(.error, log: OSLog.application, "Error writing mesh: %{Public}@", error.localizedDescription)
        }
        return nil
    }
    
    private func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            return pathURL.absoluteString
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0] as NSString
    }
}

