//
//  EmptyDataSet+MarsEx.swift
//  MarsUIKit
//
//  Created by chenxing on 2022/8/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#if canImport(RxSwift) && canImport(RxCocoa) && canImport(DZNEmptyDataSet)
import RxSwift
import RxCocoa
import DZNEmptyDataSet

public enum MarsEmptyDataSetType {
    // Customize title decription, use the default title if nil.
    case emptyData(desc: String?)
    // Customize error title decription, use the default title if nil.
    case networkError(desc: String?)
}

extension Reactive where Base: MarsEmptyDataSetMediator {
    
    public var ms_empty: Binder<MarsEmptyDataSetType> {
        return Binder(base) { (target, type) in
            let style = target.style
            switch type {
            case .emptyData(let desc):
                if let description = desc, !description.isEmpty {
                    style.title = description
                } else {
                    style.title = MarsEmptyDataSetStyle.emptyTitle
                }
                target.style = style
            case .networkError(let desc):
                if let description = desc, !description.isEmpty {
                    style.title = description
                } else {
                    style.title = MarsEmptyDataSetStyle.networkErrorTitle
                }
                target.style = style
            }
            target.bindEmptyDataSet()
            target.reloadEmptyDataSet()
        }
    }
    
}

#endif
#endif
