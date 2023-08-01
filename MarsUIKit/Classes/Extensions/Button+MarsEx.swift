//
//  Button+MarsEx.swift
//  CXSwiftKit
//
//  Created by chenxing on 2022/8/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#if canImport(RxSwift) && canImport(RxCocoa)
import RxSwift
import RxCocoa

extension MarsBase where Base : UIButton {
    public var whiteIndicator: UIActivityIndicatorView {
        get { base.ms_whiteIndicator }
        set {
            base.ms_whiteIndicator = newValue
        }
    }
}

extension UIButton {
    
    @objc public var ms_whiteIndicator: UIActivityIndicatorView {
        get {
            var indicator = objc_getAssociatedObject(self, &MarsAssociatedKey.buttonWhiteIndicator) as? UIActivityIndicatorView
            if indicator == nil {
                if #available(iOS 13.0, tvOS 13.0, *) {
                    indicator = UIActivityIndicatorView(style: .medium)
                } else {
                    indicator = UIActivityIndicatorView(style: .white)
                }
                indicator!.center = CGPoint(x: self.bounds.width / 2,
                                            y: self.bounds.height / 2)
                addSubview(indicator!)
            }
            self.ms_whiteIndicator = indicator!
            // Reset its center.
            indicator!.center = CGPoint(x: self.bounds.width / 2,
                                        y: self.bounds.height / 2)
            return indicator!
        }
        set {
            objc_setAssociatedObject(self, &MarsAssociatedKey.buttonWhiteIndicator, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension Reactive where Base: UIButton {
    
    #if os(iOS) || os(tvOS)
    public var cx_isShowIndicator: Binder<Bool> {
        return Binder(self.base, binding: { button, active in
            if active {
                objc_setAssociatedObject(button, &MarsAssociatedKey.buttonCurrentText, button.currentTitle, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                button.setTitle("", for: .normal)
                button.ms_whiteIndicator.startAnimating()
                button.isUserInteractionEnabled = false
            }
            else {
                button.ms_whiteIndicator.stopAnimating()
                if let title = objc_getAssociatedObject(button, &MarsAssociatedKey.buttonCurrentText) as? String {
                    button.setTitle(title, for: .normal)
                }
                button.isUserInteractionEnabled = true
            }
        })
    }
    #endif
}

#endif
#endif
