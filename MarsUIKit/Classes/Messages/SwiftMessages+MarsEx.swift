//
//  SwiftMessages+MarsEx.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2023/7/31.
//

import Foundation
#if os(iOS)
import UIKit
#if canImport(SwiftMessages)
import SwiftMessages

@objc public enum MarsMessagesBoxStyle: UInt8, CustomStringConvertible {
    case light, dark
    
    public var description: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}

//MARK: - SwiftMessagesWrapable

@objc public protocol SwiftMessagesWrapable {
    // iOS
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, body: String?)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?, textAlignment: NSTextAlignment)
    func ms_showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?, textAlignment: NSTextAlignment, iconImage: UIImage?, iconText: String?, buttonImage: UIImage?, buttonTitle: String?, buttonTapHandler: ((_ button: UIButton) -> Void)?)
    func ms_hideMessages()
}

extension MarsBase where Base : NSObject {
    
    public func showMessages(withStyle style: MarsMessagesBoxStyle, body: String?)
    {
        base.ms_showMessages(withStyle: style, body: body)
    }
    
    public func showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?)
    {
        base.ms_showMessages(withStyle: style, title: title, body: body)
    }
    
    public func showMessages(withStyle style: MarsMessagesBoxStyle, title: String?, body: String?, textAlignment: NSTextAlignment)
    {
        base.ms_showMessages(withStyle: style, title: title, body: body, textAlignment: textAlignment)
    }
    
    public func showMessages(
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
        base.ms_showMessages(withStyle: style,
                             title: title,
                             body: body,
                             textAlignment: textAlignment,
                             iconImage: iconImage,
                             iconText: iconText,
                             buttonImage: buttonImage,
                             buttonTitle: buttonTitle,
                             buttonTapHandler: buttonTapHandler)
    }
    
    public func hideMessages()
    {
        base.ms_hideMessages()
    }
    
}

extension NSObject: SwiftMessagesWrapable {
    
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
        ? UIColor.ms_makeColor(withHex: 0x000000, alpha: 0.6)
        : UIColor.ms_makeColor(withHex: 0xFFFFFF)
        if title != nil {
            infoView.titleLabel?.textColor = style == .dark
            ? UIColor.ms_makeColor(withHex: 0xFFFFFF, alpha: 1.0)
            : UIColor.ms_makeColor(withHex: 0x333333)
            infoView.titleLabel?.textAlignment = textAlignment
        }
        if body != nil {
            infoView.bodyLabel?.textColor = style == .dark
            ? UIColor.ms_makeColor(withHex: 0xFFFFFF, alpha: 1.0)
            : UIColor.ms_makeColor(withHex: 0x333333)
            infoView.bodyLabel?.textAlignment = textAlignment
        }
        if buttonTitle != nil {
            infoView.button?.isHidden = false
            infoView.button?.backgroundColor = UIColor.ms_makeColor(withHex: 0xFFCD4D)
            infoView.button?.setTitleColor(style == .dark
                                           ? UIColor.ms_makeColor(withHex: 0xFFFFFF, alpha: 1.0)
                                           : UIColor.ms_makeColor(withHex: 0x333333), for: .normal)
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
    
}

#endif
#endif
