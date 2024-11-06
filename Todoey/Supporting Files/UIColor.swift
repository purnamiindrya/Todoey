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
}
