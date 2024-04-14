//
//  ToastSwift+MarsEx.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2022/11/14.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#if canImport(Toast_Swift)
import Toast_Swift

//MARK: - ToastSwiftWrapable

public protocol ToastSwiftWrapable: AnyObject {
    // For iOS, e.g.:
    // func setupToast()
    // {
    //    // toggle "tap to dismiss" functionality
    //    ToastManager.shared.isTapToDismissEnabled = true
    //    //toggle queueing behavior
    //    ToastManager.shared.isQueueEnabled = true
    //    ToastManager.shared.position = .bottom
    //    var style = ToastStyle()
    //    style.backgroundColor = UIColor.Material.red
    //    style.messageColor = UIColor.Material.white
    //    style.imageSize = CGSize(width: 20, height: 20)
    //    ToastManager.shared.style = style
    // }
    func ms_showToast(_ message: String?, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, title: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, duration: TimeInterval, position: ToastPosition, title: String?, image: UIImage?, style: ToastStyle, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, duration: TimeInterval, point: CGPoint, title: String?, image: UIImage?, style: ToastStyle, completion: ((_ didTap: Bool) -> Void)?)
    func ms_hideAllToasts()
    func ms_showToastActivity(_ position: ToastPosition)
    func ms_hideToastActivity()
}

extension MarsBase where Base : UIView {
    
    public func showToast(_ message: String?, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        base.ms_showToast(message, completion: completion)
    }
    
    public func showToast(_ message: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        base.ms_showToast(message, image: image, completion: completion)
    }
    
    public func showToast(_ message: String?, title: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        base.ms_showToast(message, title: title, image: image, completion: completion)
    }
    
    public func showToast(_ message: String?, duration: TimeInterval = ToastManager.shared.duration, position: ToastPosition = ToastManager.shared.position, title: String?, image: UIImage?, style: ToastStyle, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        base.ms_showToast(message, duration: duration, position: position, title: title, image: image, style: style, completion: completion)
    }
    
    public func showToast(_ message: String?, duration: TimeInterval = ToastManager.shared.duration, point: CGPoint, title: String? = nil, image: UIImage? = nil, style: ToastStyle = ToastManager.shared.style, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        base.ms_showToast(message, duration: duration, point: point, title: title, image: image, style: style, completion: completion)
    }
    
    public func hideAllToasts()
    {
        base.ms_hideAllToasts()
    }
    
    public func showToastActivity(_ position: ToastPosition)
    {
        base.ms_showToastActivity(position)
    }
    
    public func hideToastActivity()
    {
        base.ms_hideToastActivity()
    }
    
}

extension UIView: ToastSwiftWrapable {
    
    public func ms_showToast(_ message: String?, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        ms_showToast(message, image: nil, completion: completion)
    }
    
    public func ms_showToast(_ message: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        ms_showToast(message, title: nil, image: image, style: ToastManager.shared.style, completion: completion)
    }
    
    public func ms_showToast(_ message: String?, title: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        ms_showToast(message, title: title, image: image, style: ToastManager.shared.style, completion: completion)
    }
    
    public func ms_showToast(_ message: String?, duration: TimeInterval = ToastManager.shared.duration, position: ToastPosition = ToastManager.shared.position, title: String?, image: UIImage?, style: ToastStyle, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        self.makeToast(message, duration: duration, position: position, title: title, image: image, style: style, completion: completion)
    }
    
    public func ms_showToast(_ message: String?, duration: TimeInterval = ToastManager.shared.duration, point: CGPoint, title: String? = nil, image: UIImage? = nil, style: ToastStyle = ToastManager.shared.style, completion: ((_ didTap: Bool) -> Void)? = nil)
    {
        self.makeToast(message, duration: duration, point: point, title: title, image: image, style: style, completion: completion)
    }
    
    public func ms_hideAllToasts()
    {
        self.hideAllToasts()
    }
    
    public func ms_showToastActivity(_ position: ToastPosition)
    {
        self.makeToastActivity(position)
    }
    
    public func ms_hideToastActivity()
    {
        self.hideToastActivity()
    }
    
}

#endif
#endif
