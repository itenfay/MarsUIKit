//
//  CXViewWrapable.swift
//  MarsUIKit
//
//  Created by chenxing on 2023/3/16.
//

import Foundation

@objc public enum MarsOverlayDirection: UInt8 {
    case top, left, bottom, right
}

#if os(iOS) || os(tvOS)
import UIKit
#if canImport(Toast_Swift)
import Toast_Swift
#endif

@objc public protocol CXViewWrapable: AnyObject {
    func ms_present(_ view: UIView?, completion: (() -> Void)?)
    func ms_present(_ view: UIView?, overlayView: UIView?, overlayRatio: CGFloat, overlayDirection: MarsOverlayDirection, completion: (() -> Void)?)
    func ms_dismiss(completion: (() -> Void)?)
    func ms_dismiss(overlayView: UIView?, completion: (() -> Void)?)
}

public protocol MarsToastViewWrapable: AnyObject {
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
    #if canImport(Toast_Swift)
    func ms_showToast(_ message: String?, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, title: String?, image: UIImage?, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, duration: TimeInterval, position: ToastPosition, title: String?, image: UIImage?, style: ToastStyle, completion: ((_ didTap: Bool) -> Void)?)
    func ms_showToast(_ message: String?, duration: TimeInterval, point: CGPoint, title: String?, image: UIImage?, style: ToastStyle, completion: ((_ didTap: Bool) -> Void)?)
    func ms_hideAllToasts()
    func ms_showToastActivity(_ position: ToastPosition)
    func ms_hideToastActivity()
    #endif
}

#if os(iOS) && canImport(OverlayController)
import OverlayController
#endif

public protocol MarsSwiftViewWrapable: AnyObject {
    #if os(iOS) && canImport(OverlayController)
    func ms_ovcPresent(_ view: UIView?, maskStyle: OverlayMaskStyle, position: OverlayLayoutPosition, positionOffset: CGFloat, style: OverlaySlideStyle, windowLevel: OverlayWindowLevel, isDismissOnMaskTouched: Bool, isPanGestureEnabled: Bool, panDismissPercent: CGFloat, duration: TimeInterval, completion: (() -> Void)?, didDismiss: @escaping () -> Void)
    func ms_ovcDismiss(duration: TimeInterval, completion: (() -> Void)?)
    #endif
}

#endif
