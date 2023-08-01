//
//  View+MarsEx.swift
//  MarsUIKit
//
//  Created by chenxing on 2022/11/14.
//

#if os(iOS)
#if canImport(OverlayController)
import OverlayController
#endif

//MARK: - MarsSwiftViewWrapable

#if os(iOS) && canImport(OverlayController)

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

extension UIView: MarsSwiftViewWrapable {
    
    private var ms_overlayController: OverlayController? {
        get {
            return objc_getAssociatedObject(self, &MarsAssociatedKey.presentByOverlayController) as? OverlayController
        }
        set (ovc) {
            objc_setAssociatedObject(self, &MarsAssociatedKey.presentByOverlayController, ovc, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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

#if os(iOS) && canImport(Toast_Swift)
import Toast_Swift

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
    
    public func ms_hideToastActivity()
    {
        base.ms_hideToastActivity()
    }
    
}

extension UIView: MarsToastViewWrapable {
    
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
