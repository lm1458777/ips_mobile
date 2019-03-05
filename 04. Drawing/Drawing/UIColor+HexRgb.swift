//
//  UIColor+HexRgb.swift
//  Navigation
//
//  Created by maksim.levakov on 3/10/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: UInt) {
        self.init(
            red: Int((rgb >> 16) & 0xFF),
            green: Int((rgb >> 8) & 0xFF),
            blue: Int(rgb & 0xFF)
        )
    }

    func rgbaValues() -> (r: Int, g: Int, b: Int, a: Int)? {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0

        guard getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) else {
            // Could not extract RGBA components:
            return nil
        }

        return (
            r: Int(fRed * 255.0),
            g: Int(fGreen * 255.0),
            b: Int(fBlue * 255.0),
            a: Int(fAlpha * 255.0)
        )
    }

    func argb() -> UInt? {
        //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
        guard let (r, g, b, a) = rgbaValues() else {
            return nil
        }

        return (UInt(a) << 24) + (UInt(r) << 16) + (UInt(g) << 8) + UInt(b)
    }
}
