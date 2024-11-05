//
//  UIImage+EXT.swift
//
//  Created by Jamal on 8/23/23.
//

import Foundation
import SDWebImage

extension UIImageView {
    func loadImageFrom(url: String?) {
        guard let url = url else { return }
        sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "AppIcon"))
    }
}

extension UIImage {
    
    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }
    
    func getSizeIn(_ type: DataUnits) -> Double {
        
        guard let data = self.pngData() else {
            return 0
        }
        
        var size: Double = 0.0
        
        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }
        
        return size
    }
    
    func compressedData(maxSizeInByte: Int)-> Data {
        
        var compressQuality: CGFloat = 1
        var imageData = self.jpegData(compressionQuality: 1) ?? Data()
        
        var imageBytes = imageData.count
        
        while imageBytes >  maxSizeInByte {
            compressQuality = CGFloat(maxSizeInByte) / CGFloat(imageBytes)
            imageData = self.jpegData(compressionQuality: compressQuality)!
            imageBytes = imageData.count
        }
        
        return imageData
    }
    
}
