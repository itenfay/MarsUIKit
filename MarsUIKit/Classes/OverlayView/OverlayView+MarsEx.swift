//
//  OverlayView+MarsEx.swift
//  MarsUIKit
//
//  Created by Tenfay on 2022/11/14.
//

#if os(iOS)
import UIKit
#if canImport(OverlayController)
import OverlayController

/// The key for presenting view by overlay controller.
fileprivate var presentByOverlayController = "ms.presentView.overlayController"

//MARK: - MarsOverlayViewWrapable

public protocol MarsOverlayViewWrapable: AnyObject {
    func ms_ovcPresent(_ view: UIView?, maskStyle: OverlayMaskStyle, position: OverlayLayoutPosition, positionOffset: CGFloat, style: OverlaySlideStyle, windowLevel: OverlayWindowLevel, isDismissOnMaskTouched: Bool, isPanGestureEnabled: Bool, panDismissPercent: CGFloat, duration: TimeInterval, completion: (() -> Void)?, didDismiss: @escaping () -> Void)
    func ms_ovcDismiss(duration: TimeInterval, completion: (() -> Void)?)
}

extension MarsBase where Base : UIView {
    
    public func ovcPresent(
        _ view: UIView?,
        maskStyle: OverlayMaskStyle = .black(opacity: 0.7),
        position: OverlayLayoutPosition = .bottom,
        positionOffset: CGFloat = 0,
        style: OverlaySlideStyle = .fromToBottom,
        windowLevel: OverlayWindowLevel = .low,
        isDismissOnMaskTouched: Bool = true,
        isPanGestureEnabled: Bool = true,
        panDismissPercent: CGFloat = 0.5,
        duration: TimeInterval = 0.3,
        completion: (() -> Void)? = nil,
        didDismiss: @escaping () -> Void)
    {
        base.ms_ovcPresent(view,
                           maskStyle: maskStyle,
                           position: position,
                           positionOffset: positionOffset,
                           style: style,
                           windowLevel: windowLevel,
                           isDismissOnMaskTouched: isDismissOnMaskTouched,
                           isPanGestureEnabled: isPanGestureEnabled,
                           panDismissPercent: panDismissPercent,
                           duration: duration,
                           completion: completion,
                           didDismiss: didDismiss)
    }
    
    public func ovcDismiss(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        base.ms_ovcDismiss(duration: duration, completion: completion)
    }
    
}

extension UIView: MarsOverlayViewWrapable {
    
    private var ms_overlayController: OverlayController? {
        get {
            return objc_getAssociatedObject(self, &presentByOverlayController) as? OverlayController
        }
        set (ovc) {
            objc_setAssociatedObject(self, &presentByOverlayController, ovc, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func ms_ovcPresent(
        _ view: UIView?,
        maskStyle: OverlayMaskStyle = .black(opacity: 0.7),
        position: OverlayLayoutPosition = .bottom,
        positionOffset: CGFloat = 0,
        style: OverlaySlideStyle = .fromToBottom,
        windowLevel: OverlayWindowLevel = .low,
        isDismissOnMaskTouched: Bool = true,
        isPanGestureEnabled: Bool = true,
        panDismissPercent: CGFloat = 0.5,
        duration: TimeInterval = 0.3,
        completion: (() -> Void)? = nil,
        didDismiss: @escaping () -> Void)
    {
        guard let overlayView = view else { return }
        overlayView.ms_overlayController = OverlayController(view: overlayView)
        overlayView.ms_overlayController?.maskStyle = maskStyle
        overlayView.ms_overlayController?.layoutPosition = position
        overlayView.ms_overlayController?.offsetSpacing = positionOffset
        overlayView.ms_overlayController?.presentationStyle = style
        overlayView.ms_overlayController?.windowLevel = windowLevel
        overlayView.ms_overlayController?.isDismissOnMaskTouched = isDismissOnMaskTouched
        overlayView.ms_overlayController?.isPanGestureEnabled = isPanGestureEnabled
        overlayView.ms_overlayController?.panDismissRatio = panDismissPercent
        overlayView.ms_overlayController?.present(in: self, duration: duration, completion: completion)
        overlayView.ms_overlayController?.didDismissClosure = { [weak oView = overlayView] ovc in
            didDismiss()
            oView?.ms_overlayController = nil
        }
    }
    
    public func ms_ovcDismiss(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        assert(ms_overlayController != nil, "Please invoke ovcDismiss(::) method with the overlay view.")
        ms_overlayController?.dissmiss(duration: duration, completion: { [weak self] in
            completion?()
            self?.ms_overlayController = nil
        })
    }
    
}

#endif
#endif
