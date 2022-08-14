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
 
public protocol QSTabBarDelegate : AnyObject {
    func numbersInQSTabBarView(_ tabBarView: UIView) -> UInt
    func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, willSelectItem originIdx: UInt, targetIdx: UInt)
    func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, didSelectItem originIdx: UInt, targetIdx: UInt)
    func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, didSelectItemAgain originIdx: UInt, targetIdx: UInt)
}

public class QSTabBarView : UIView, QSTabBarViewProtocol {
    weak private var delegate: QSTabBarDelegate?
    private var index: UInt = 0
    
    //  MARK: QSTabBarViewProtocol
    public var indicatorHidden: Bool = false
    public var indicatorAnimated: Bool = true
    public var indicatorHeight: Float = 5
    public var itemSpacing: Float = 0
    public lazy var selectIndicatorView: UIView = UIView()
    public lazy var contentScrollView: UIScrollView = UIScrollView()
    
    public func reloadData() {
        
    }
    
    public func scroll(to index: UInt, animated: Bool) {
        
    }
    
    public func configDelegate(_ delegate: QSTabBarDelegate) {
        self.delegate = delegate
    }
    
    public func update(with progress: Float, relativeProgress: Float, leftIndex: Int, rightIndex: Int) {
        
    }
}
