//
//  MarsBase.swift
//  MarsUIKit
//
//  Created by chenxing on 2023/7/31.
//

import Foundation

public struct MarsBase<Base> {
    let base: Base
    
    init(base: Base) {
        self.base = base
    }
}

public protocol MarsBaseCompatible {
    associatedtype T
    var ms: MarsBase<T> { get set }
    static var ms: MarsBase<T>.Type { get set }
}

extension MarsBaseCompatible {
    public var ms: MarsBase<Self> {
        get { MarsBase(base: self) }
        set {}
    }
    
    public static var ms: MarsBase<Self>.Type {
        get { MarsBase<Self>.self }
        set {}
    }
}

extension NSObject: MarsBaseCompatible {}
