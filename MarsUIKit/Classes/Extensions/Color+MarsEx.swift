//
//  Color+MarsEx.swift
//  MarsUIKit
//
//  Created by chenxing on 2023/7/31.
//

import Foundation
#if os(iOS)

extension UIColor {
    
    /// Creates a color object using the specified opacity and RGB component values.
    ///
    /// - Parameters:
    ///   - red: The red value of the color object.
    ///   - green: The green value of the color object.
    ///   - blue: The blue value of the color object.
    ///   - alpha: The opacity value of the color object.
    /// - Returns: The color object. The color information represented by this object is in an RGB colorspace.
    @objc public static func ms_color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor?
    {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var _alpha = alpha
        if _alpha < 0 { _alpha = 0 }
        if _alpha > 1 { _alpha = 1 }
        
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: _alpha)
    }
    
    /// Creates Color from RGB values with optional alpha.
    ///
    /// - Parameters:
    ///   - hex: Hex Int (example: 0xDEA3B6).
    ///   - alpha: Optional alpha value (default is 1).
    @objc public static func ms_color(hex: Int, alpha: CGFloat = 1) -> UIColor?
    {
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        return ms_color(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
    
    /// Creates Color from hexadecimal string with optional alpha.
    ///
    /// - Parameters:
    ///   - hexString: Hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - alpha: Optional alpha value (default is 1).
    @objc public static func ms_color(hexString: String, alpha: CGFloat = 1) -> UIColor?
    {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string = hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        return ms_color(hex: hexValue, alpha: alpha)
    }
    
    /// Draws an image of the color with the specified size.
    ///
    /// - Parameter size: The size of getting new image.
    /// - Returns: An image of the color with the specified size.
    @objc public func ms_drawImage(with size: CGSize = CGSize(width: 1, height: 1)) -> UIImage?
    {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext()
        else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(self.cgColor)
        context.fill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

#endif
