//
//  QSTabBarItem.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation
import UIKit

public protocol QSTabBarItemProtocol {
    var itemIndex: UInt { get }
    var itemWidth: Float { get }
    func config(with index: UInt)
    func config(with customWidth: Float)
    func config(with actionBlock: @escaping (UInt, UInt) -> Void)
    func update(with isHighlight: Bool)
    func setupMaxTextLengthLimit(_ limit: UInt)
}

public class QSTabBarItem: UIView,  QSTabBarItemProtocol {
    private var actionBlock: ((UInt, UInt) -> Void)?
    private var isHighlight: Bool = false
    private var customWidth: Float = 0
    private var index: UInt = 0
    private var limit: UInt = 0
    
    //MARK: QSTabBarItemProtocol
    public var itemIndex: UInt  = 0
    public var itemWidth: Float = 0
    
    public func config(with index: UInt) {
        self.index = index
    }
    
    public func config(with customWidth: Float) {
        self.customWidth = customWidth
    }
    
    public func config(with actionBlock: @escaping (UInt, UInt) -> Void) {
        self.actionBlock = actionBlock;
    }
    
    public func update(with isHighlight: Bool) {
        self.isHighlight = isHighlight
    }
    
    public func setupMaxTextLengthLimit(_ limit: UInt) {
        self.limit = limit
    }
}
