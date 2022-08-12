//
//  QSTabBarItem.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation

public protocol QSTabBarItemProtocol {
    var itemIndex: UInt { get }
    var itemWidth: Float { get }
    func config(with index: UInt)
    func config(with customWidth: Float)
    func config(with actionBlock: (UInt, UInt) -> Void)
    func update(with isHighlight: Bool)
    func setupMaxTextLengthLimit(_ limit: UInt)
}

