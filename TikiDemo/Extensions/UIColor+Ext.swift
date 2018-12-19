//
//  UIColor+Ext.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit

public extension UIColor {

    convenience init(hex: Int) {
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
        
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(decimalRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    class func backgroundColorItems() -> [UIColor] {
        return [UIColor(hexString:"#16702e"), UIColor(hexString:"#005a51"), UIColor(hexString:"#996c00"), UIColor(hexString:"#5c0a6b"), UIColor(hexString:"#006d90"), UIColor(hexString:"#974e06"), UIColor(hexString:"#99272e"), UIColor(hexString:"#89221f"), UIColor(hexString:"#00345d")]
    }
    
    class func backgroundColorItem(index: Int) -> UIColor {
        return self.backgroundColorItems()[index % self.backgroundColorItems().count]
    }
}
