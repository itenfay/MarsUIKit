//
//  MarsEmptyDataSetStyle.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2022/10/19.
//

#if os(iOS) || os(tvOS)
import UIKit

//MARK: - EmptyDataSetStyle

public class MarsEmptyDataSetStyle: NSObject {
    /// The background color for empty data set.
    @objc public var backgroundColor: UIColor = UIColor.ms_makeColor(withHex: 0xFFFFFF)
    /// The title for empty data set.
    @objc public var title: String?
    /// The title color for empty data set.
    @objc public var titleColor: UIColor = UIColor.ms_makeColor(withHex: 0x333333)
    /// The title font for empty data set.
    @objc public var titleFont: UIFont = UIFont.systemFont(ofSize: 13, weight: .medium)
    
    /// The description for empty data set.
    @objc public var descriptionString: String?
    /// The description color for empty data set.
    @objc public var descriptionColor: UIColor = UIColor.ms_makeColor(withHex: 0x333333)
    /// The description font for empty data set.
    @objc public var descriptionFont: UIFont = UIFont.systemFont(ofSize: 13, weight: .medium)
    
    /// The image font for empty data set.
    @objc public var image: UIImage?
    /// The loading animated image for empty data set.
    @objc public var loadingAnimatedImage: UIImage?
    
    /// The button title for empty data set.
    @objc public var buttonTitle: String?
    /// The button color for empty data set.
    @objc public var buttonColor: UIColor = UIColor.ms_makeColor(withHex: 0x9D1420)
    /// The button font for empty data set.
    @objc public var buttonFont: UIFont = UIFont.systemFont(ofSize: 13, weight: .medium)
    /// The button normal image font for empty data set.
    @objc public var buttonNormalImage: UIImage?
    /// The button highlighted image font for empty data set.
    @objc public var buttonHighlightedImage: UIImage?
    
    /// The vertical offset for empty data set.
    @objc public var verticalOffset: CGFloat = 0
    /// The vertical distance for empty data set.
    @objc public var verticalSpace: CGFloat = 20
    
    @objc public static var emptyTitle: String = "暂无数据"
    @objc public static var networkErrorTitle: String = "服务异常，网络断开或飞行模式"
}

#endif
