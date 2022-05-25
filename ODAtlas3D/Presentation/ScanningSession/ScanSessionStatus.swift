//
//  ScanSessionStatus.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 24/5/22.
//

import SwiftUI

struct ScanSessionStatus: View {
    
    var delegate: ScanningTriggerDelegate?
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Ready to scan!")
                .font(Font.system(.title, design: .default).weight(.semibold))
                .foregroundColor(Color(.systemGray6))
            Text("Scan at least one foot to continue process")
                .font(.title2)
                .foregroundColor(Color(.systemGray2))
            Text("Scanning status")
                .font(.title3)
                .foregroundColor(Color(.systemGray2))
            VStack(spacing: 16) {
                Button(action: {
                    delegate?.runLeftScan()
                }) {
                    HStack(spacing: 20) {
                        Text("Scan left foot")
                            .font(Font.system(.title2, design: .default).weight(.semibold))
                            .foregroundColor(Color(.sRGB, red: 11/255, green: 158/255, blue: 129/255))
                        Spacer()
                        Image(systemName: "checkmark.seal.fill")
                            .imageScale(.large)
                            .font(.title2)
                            .foregroundColor(Color(.sRGB, red: 11/255, green: 158/255, blue: 129/255))
                    }
                    .foregroundColor(Color.clear)
                    .padding()
                    .background(Color(.sRGB, red: 114/255, green: 252/255, blue: 222/255))
                    .cornerRadius(5)
                    .frame(height: 65)
                    .clipped()
                    .background(RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.systemFill)), alignment: .center)
                }
                
                Button(action: {
                    delegate?.runRightScan()
                }) {
                    HStack(spacing: 16) {
                        Text("Scan right foot")
                            .font(Font.system(.title2, design: .default).weight(.semibold))
                            .foregroundColor(Color(.sRGB, red: 13/255, green: 59/255, blue: 102/255))
                        Spacer()
                        Image(systemName: "camera.metering.spot")
                            .imageScale(.large)
                            .font(.title2)
                            .foregroundColor(Color(.sRGB, red: 13/255, green: 59/255, blue: 102/255))
                    }
                    .foregroundColor(Color.cyan)
                    .padding()
                    .background(Color.cyan)
                    .cornerRadius(5)
                    .frame(height: 65)
                    .clipped()
                }
            }
            .frame(width: 375)
            .clipped()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5, style: .continuous)
            .stroke(Color(.systemGray6), lineWidth: 1)
            .background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color.primary))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .clipped()
            .padding(0), alignment: .center)
        .frame(width: 834, height: 1194)
        .clipped()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

struct ScanSessionStatus_Previews: PreviewProvider {
    static var previews: some View {
        ScanSessionStatus()
    }
}
