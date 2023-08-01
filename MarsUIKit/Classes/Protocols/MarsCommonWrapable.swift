//
//  MarsCommonWrapable.swift
//  MarsUIKit
//
//  Created by chenxing on 2023/3/16.
//

#if os(iOS) || os(tvOS)
import UIKit
#if canImport(SVProgressHUD)
import SVProgressHUD
#endif
#if canImport(SwiftMessages)
import SwiftMessages
#endif
#if canImport(Toaster)
import Toaster
#endif

@objc public enum MarsMessagesBoxStyle: UInt8, CustomStringConvertible {
    case light, dark
    
    public var description: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}

@objc public enum MarsToasterDurationType: UInt8, CustomStringConvertible {
    case short, long, longer
    
    public var description: String {
        switch self {
        case .short: return "Short"
        case .long: return "Long"
        case .longer: return "Longer"
        }
    }
}

@objc public protocol MarsCommonWrapable {
    // iOS || tvOS
    #if canImport(SVProgressHUD)
    func ms_showProgressHUD(withStatus status: String?)
    func ms_showProgressHUD(withStatus status: String?, delay: TimeInterval)
    func ms_dismissProgressHUD()
    func ms_dismissProgressHUD(withDelay delay: TimeInterval)
    #endif
    
    // iOS
    #if canImport(SwiftMessages)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, body: String?)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?, textAlignment: NSTextAlignment)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?, textAlignment: NSTextAlignment, iconImage: UIImage?, iconText: String?, buttonImage: UIImage?, buttonTitle: String?, buttonTapHandler: ((_ button: UIButton) -> Void)?)
    func ms_hideMessages()
    #endif
    
    // iOS, e.g.:
    // func setupToaster()
    // {
    //    ToastCenter.default.isQueueEnabled = false
    //    ToastView.appearance().bottomOffsetPortrait = cxScreenHeight/2 - 10
    //    let sizeScale: CGFloat = (CGFloat.cx.screenWidth < 375) ? 0.9 : 1.0
    //    ToastView.appearance().font = UIFont.systemFont(ofSize: sizeScale * 16)
    // }
    #if canImport(Toaster)
    func ms_restoreToastAppearance()
    func ms_updateToastAppearance(with bottomOffsetPortrait: CGFloat, maxWidthRatio: CGFloat)
    func ms_getToastDuration(type: MarsToasterDurationType, block: (() -> TimeInterval)?) -> TimeInterval
    func ms_makeToast(text: String)
    func ms_makeToast(text: String, delay: TimeInterval, duration: TimeInterval)
    func ms_makeToast(attributedString: NSAttributedString)
    func ms_makeToast(attributedString: NSAttributedString, delay: TimeInterval, duration: TimeInterval)
    #endif
    
}

#endif
