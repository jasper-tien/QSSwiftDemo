//
//  QSTabBarView.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation
import UIKit

public protocol QSTabBarViewProtocol {
    var indicatorHidden: Bool { set get }
    var indicatorAnimated: Bool { set get }
    var indicatorHeight: Float { set get }
    var itemSpacing: Float { set get }
    var selectIndicatorView: UIView { get }
    var contentScrollView: UIScrollView { get }
    func reloadData()
    func scroll(to index: UInt, animated: Bool)
    func configDelegate(_ delegate: QSTabBarDelegate)
    func update(with progress: Float, relativeProgress: Float, leftIndex: Int, rightIndex: Int)
}
 
public protocol QSTabBarDelegate {
    func numbersInQSTabBarView(_ tabBarView: UIView) -> UInt
    func tabBarView(_ tabBarView: UIView, willSelectItem originIdx: UInt, targetIdx: UInt)
    func tabBarView(_ tabBarView: UIView, didSelectItem originIdx: UInt, targetIdx: UInt)
    func tabBarView(_ tabBarView: UIView, didSelectItemAgain originIdx: UInt, targetIdx: UInt)
}

public class QSTabBarView : QSTabBarViewProtocol {
    
}
