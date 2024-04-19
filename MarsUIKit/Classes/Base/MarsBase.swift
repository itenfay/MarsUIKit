//
//  MarsBase.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2023/7/31.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#endif

public struct MarsBase<Base> {
    let base: Base
    
    init(base: Base) {
        self.base = base
    }
}

public protocol MarsBaseCompatible {
    associatedtype T
    var ms: MarsBase<T> { get set }
    static var ms: MarsBase<T>.Type { get set }
}

extension MarsBaseCompatible {
    public var ms: MarsBase<Self> {
        get { MarsBase(base: self) }
        set {}
    }
    
    public static var ms: MarsBase<Self>.Type {
        get { MarsBase<Self>.self }
        set {}
    }
}

extension NSObject: MarsBaseCompatible {}

#if os(iOS) || os(tvOS)

/// The extension for UIColor.
extension UIColor {
    /// Draws an image of the color with the specified size.
    ///
    /// - Parameter size: The size of getting new image.
    /// - Returns: An image of the color with the specified size.
    @objc public func ms_drawImage(withSize size: CGSize = CGSize(width: 1, height: 1)) -> UIImage?
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
    
    /// Creates Color from RGB values with optional alpha.
    ///
    /// - Parameters:
    ///   - hex: Hex Int (example: 0xDEA3B6).
    ///   - alpha: Optional alpha value (default is 1).
    @objc static public func ms_makeColor(withHex hex: Int, alpha: CGFloat = 1) -> UIColor
    {
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
}

#endif
