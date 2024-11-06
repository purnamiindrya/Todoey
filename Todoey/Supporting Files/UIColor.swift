//
//  GenerateColor.swift
//  Todoey
//
//  Created by purnami indryaswari on 06/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

extension UIColor {
// Generate a random color
static func random() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0,
                   green: CGFloat(arc4random_uniform(256)) / 255.0,
                   blue: CGFloat(arc4random_uniform(256)) / 255.0,
                   alpha: 1.0)
}

// Convert UIColor to HEX string
func toHex() -> String {
    let components = self.cgColor.components
    let red = components?[0] ?? 0.0
    let green = components?[1] ?? 0.0
    let blue = components?[2] ?? 0.0
    
    let rgb = (Int(red * 255), Int(green * 255), Int(blue * 255))
    return String(format: "#%02X%02X%02X", rgb.0, rgb.1, rgb.2)
}

convenience init(hex: String) {
        // Remove any leading '#' if it exists
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }
        
        // Ensure it's a valid 6-digit hex string
        guard hexSanitized.count == 6 else {
            self.init(white: 1.0, alpha: 1.0) // Default to white if invalid
            return
        }
        
        // Extract the RGB values from the hex string
        let scanner = Scanner(string: hexSanitized)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        // Get the RGB components from the hex value
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        
        // Initialize the UIColor with the RGB components
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

func luminance() -> CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Get the RGB and Alpha components
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Adjust for the perceived brightness of the RGB components
        let luminance = red * 0.299 + green * 0.587 + blue * 0.114
        
        return luminance
    }
    
    // Get contrasting text color based on luminance
    func getContrastingTextColor() -> UIColor {
        // Calculate luminance of the color
        let luminanceValue = luminance()
        
        // If luminance is less than 0.5, consider it a dark background -> white text
        if luminanceValue < 0.5 {
            return .white
        } else {
            // Light background -> black text
            return .black
        }
    }
    
    // Adjust for transparency by blending with a white or black background (depending on alpha)
    func adjustedColorForTransparency() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // If the alpha is not 1.0 (fully opaque), calculate the effective background color.
        if alpha < 1.0 {
            let white = UIColor.white
            let whiteRed: CGFloat = 1.0, whiteGreen: CGFloat = 1.0, whiteBlue: CGFloat = 1.0
            let adjustedRed = (1 - alpha) * whiteRed + alpha * red
            let adjustedGreen = (1 - alpha) * whiteGreen + alpha * green
            let adjustedBlue = (1 - alpha) * whiteBlue + alpha * blue
            return UIColor(red: adjustedRed, green: adjustedGreen, blue: adjustedBlue, alpha: 1.0)
        } else {
            return self // No change needed if fully opaque
        }
    }
}
