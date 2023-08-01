//
//  Object+MarsEx.swift
//  MarsUIKit
//
//  Created by chenxing on 2023/7/31.
//

import Foundation
#if canImport(SVProgressHUD)
import SVProgressHUD
#endif
#if canImport(SwiftMessages)
import SwiftMessages
#endif
#if canImport(Toaster)
import Toaster
#endif

#if os(iOS) || os(tvOS)
import UIKit

//MARK: - MarsCommonWrapable

extension NSObject: MarsCommonWrapable {
    
    #if canImport(SVProgressHUD)
    //Set up.
    //SVProgressHUD.setDefaultStyle(.dark)
    //SVProgressHUD.setDefaultMaskType(.custom)
    //SVProgressHUD.setDefaultAnimationType(.flat)
    
    /// Show progress HUD with the status.
    public func ms_showProgressHUD(withStatus status: String?)
    {
        ms_showProgressHUD(withStatus: status, delay: 0)
    }
    
    /// Show progress HUD with the status and delay.
    public func ms_showProgressHUD(withStatus status: String?, delay: TimeInterval)
    {
        if delay > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                SVProgressHUD.show(withStatus: status)
            }
        } else {
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    /// Dismiss progress HUD.
    public func ms_dismissProgressHUD()
    {
        ms_dismissProgressHUD(withDelay: 0.3)
    }
    
    /// Dismiss progress HUD with the delay.
    public func ms_dismissProgressHUD(withDelay delay: TimeInterval)
    {
        SVProgressHUD.dismiss(withDelay: delay)
    }
    #endif
    
    #if canImport(SwiftMessages)
    public func ms_showMessages(withStyle style: MarsMessagesBoxStyle, body: String?)
    {
        ms_showMessages(withStyle: style, title: nil, body: body)
    }
    
    public func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?)
    {
        ms_showMessages(withStyle: style, title: title, body: body, textAlignment: .center)
    }
    
    public func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?, textAlignment: NSTextAlignment)
    {
        ms_showMessages(withStyle: style,
                        title: title, body: body,
                        textAlignment: textAlignment,
                        iconImage: nil,iconText: nil,
                        buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
    }
    
    public func ms_showMessages(
        withStyle style: MarsMessagesBoxStyle,
        title: String?,
        body: String?,
        textAlignment: NSTextAlignment,
        iconImage: UIImage?,
        iconText: String?,
        buttonImage: UIImage?,
        buttonTitle: String?,
        buttonTapHandler: ((_ button: UIButton) -> Void)?)
    {
        let infoView = MessageView.viewFromNib(layout: .cardView)
        infoView.configureTheme(.info)
        infoView.configureDropShadow()
        infoView.configureContent(title: title, body: body, iconImage: iconImage, iconText: iconText, buttonImage: buttonImage, buttonTitle: buttonTitle, buttonTapHandler: buttonTapHandler)
        infoView.backgroundView.backgroundColor = style == .dark
        ? UIColor.ms_color(hexString: "#000000", alpha: 0.7)
        : UIColor.ms_color(hexString: "#FFFFFF")
        if title != nil {
            infoView.titleLabel?.textColor = style == .dark
            ? UIColor.ms_color(hexString: "#FFFFFF", alpha: 0.9)
            : UIColor.ms_color(hexString: "0x333333")
            infoView.titleLabel?.textAlignment = textAlignment
        }
        if body != nil {
            infoView.bodyLabel?.textColor = style == .dark
            ? UIColor.ms_color(hexString: "#FFFFFF", alpha: 0.9)
            : UIColor.ms_color(hexString: "0x333333")
            infoView.bodyLabel?.textAlignment = textAlignment
        }
        if buttonTitle != nil {
            infoView.button?.isHidden = false
            infoView.button?.backgroundColor = UIColor.ms_color(hexString: "0xFFCD4D")
            infoView.button?.setTitleColor(style == .dark
                                           ? UIColor.ms_color(hexString: "#FFFFFF", alpha: 0.9)
                                           : UIColor.ms_color(hexString: "0x333333"), for: .normal)
        } else {
            infoView.button?.isHidden = buttonImage != nil ? false : true
        }
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: infoConfig, view: infoView)
    }
    
    public func ms_hideMessages()
    {
        SwiftMessages.hideAll()
    }
    #endif
    
    #if canImport(Toaster)
    public func ms_restoreToastAppearance()
    {
        ms_updateToastAppearance(with: 0, maxWidthRatio: 0)
    }
    
    public func ms_updateToastAppearance(with bottomOffsetPortrait: CGFloat, maxWidthRatio: CGFloat)
    {
        let scrBounds = UIScreen.main.bounds
        let appearance = ToastView.appearance()
        appearance.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        appearance.textColor = .white
        let sizeScale: CGFloat = (scrBounds.width < 375) ? 0.9 : 1.0
        appearance.font = .systemFont(ofSize: sizeScale * 16)
        appearance.textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        if bottomOffsetPortrait > 0 {
            appearance.bottomOffsetPortrait = bottomOffsetPortrait
        } else {
            appearance.bottomOffsetPortrait = scrBounds.height/2 - 10
        }
        // TODU: Ambiguous use of 'cornerRadius'
        //appearance.cornerRadius = 10
        if maxWidthRatio > 0 {
            appearance.maxWidthRatio = maxWidthRatio
        }
    }
    
    public func ms_getToastDuration(type: MarsToasterDurationType, block: (() -> TimeInterval)?) -> TimeInterval
    {
        switch type {
        case .short: return Delay.short
        case .long: return Delay.long
        case .longer: return (block != nil) ? block!() : Delay.long
        }
    }
    
    public func ms_makeToast(text: String)
    {
        ms_makeToast(text: text, delay: 0, duration: Delay.short)
    }
    
    public func ms_makeToast(text: String, delay: TimeInterval, duration: TimeInterval)
    {
        Toast(text: text, delay: delay, duration: duration).show()
    }
    
    public func ms_makeToast(attributedString: NSAttributedString)
    {
        ms_makeToast(attributedString: attributedString, delay: 0, duration: Delay.short)
    }
    
    public func ms_makeToast(attributedString: NSAttributedString, delay: TimeInterval, duration: TimeInterval)
    {
        Toast(attributedText: attributedString, delay: delay, duration: duration).show()
    }
    #endif
    
}

#endif
