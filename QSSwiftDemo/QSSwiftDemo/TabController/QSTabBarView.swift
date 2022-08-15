//
//  QSTabBarView.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation
import UIKit
import simd

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
    func tabBarView(_ tabBarView: UIView, index: UInt) -> UIView & QSTabBarItemProtocol
    func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, willSelectItem originIdx: UInt, targetIdx: UInt)
    func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, didSelectItem originIdx: UInt, targetIdx: UInt)
    func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, didSelectItemAgain originIdx: UInt, targetIdx: UInt)
}

public class QSTabBarView : UIView, QSTabBarViewProtocol {
    weak private var delegate: QSTabBarDelegate?
    private var selectIndex: UInt = 0
    private lazy var itemViews: [UIView & QSTabBarItemProtocol] = []
    public static let tabBarAnimatedDuration = 0.25
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //  MARK: QSTabBarViewProtocol
    public var indicatorHidden: Bool = false
    public var indicatorAnimated: Bool = true
    public var indicatorHeight: Float = 5
    public var itemSpacing: Float = 0
    public lazy var selectIndicatorView: UIView = UIView()
    public lazy var contentScrollView: UIScrollView = UIScrollView()
    
    public func reloadData() {
        resetItemViews()
        createAndCongigItemViews()
        updateItemsLayout()
        updateSelectIndicatorLayout()
    }
    
    public func scroll(to index: UInt, animated: Bool) {
        self.switchItem(with: index, animated: animated, completion: nil)
    }
    
    public func configDelegate(_ delegate: QSTabBarDelegate) {
        self.delegate = delegate
    }
    
    public func update(with progress: Float, relativeProgress: Float, leftIndex: Int, rightIndex: Int) {
        if progress.isNaN || relativeProgress.isNaN || leftIndex < 0 || rightIndex < 0 {
            return
        }
        
        let leftView: (UIView & QSTabBarItemProtocol)? = fetchTabBarItem(with: UInt(leftIndex))
        let rightView: (UIView & QSTabBarItemProtocol)? = fetchTabBarItem(with: UInt(rightIndex))
        if leftView == nil || rightView == nil {
            return
        }
        
        let leftViewPointX = leftView!.frame.minX
        let rightViewPointX = rightView!.frame.minX
        let leftViewWidth = leftView!.frame.width
        let rightViewWidth = rightView!.frame.width
        
        var frame = selectIndicatorView.frame
        frame.origin.x = leftViewPointX + (rightViewPointX - leftViewPointX) * CGFloat(relativeProgress)
        frame.size.width = leftViewWidth + (rightViewWidth - leftViewWidth) * CGFloat(relativeProgress);
        selectIndicatorView.frame = frame
        
        if contentScrollView.isScrollEnabled {
            let itemCount: CGFloat = CGFloat(itemViews.count)
            let offsetProgress = CGFloat(progress) * itemCount / (itemCount - 1);
            let x = (contentScrollView.contentSize.width - contentScrollView.frame.width) * offsetProgress
            contentScrollView.contentOffset = CGPoint(x: x, y: 0)
        }
    }
    
    // MARK: private
    
    private func setupSubviews() {
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(contentScrollView)
        
        selectIndicatorView.backgroundColor = UIColor.clear
        self.addSubview(selectIndicatorView)
    }
    
    private func resetItemViews() {
        for itemView in itemViews {
            if itemView.superview != nil {
                itemView.removeFromSuperview()
            }
        }
        itemViews.removeAll()
    }
    
    private func createAndCongigItemViews() {
        if delegate == nil {
            return
        }
        
        let itemNum = delegate?.numbersInQSTabBarView(self) ?? 0
        if itemNum == 0 {
            return
        }

        for index in 0..<itemNum {
            let itemView = delegate?.tabBarView(self, index: index) ?? QSTabBarItem()
            itemViews.append(itemView)
            
            itemView.config { index, tapsRequiredNumber in
                if tapsRequiredNumber == 1 {
                    self.itemClickAction(with: index)
                } else if tapsRequiredNumber == 1 {
                    self.itemDoubleClickAction(with: index)
                }
            }
            
            let isHightlight: Bool = (selectIndex == index) ? true : false
            itemView.update(with: isHightlight)
            itemView.config(with: index)
        }
    }
    
    private func switchItem(with index: UInt, animated: Bool, completion: ((Bool) -> Void)?) {
        if selectIndex == index || itemViews.count == 0 { return }
        let switchItmeBlock = { () -> Void in
            self.selectIndex = index
            self.updateSelectIndicatorLayout()
            self.updateItemViewHighlight(with: index)
            self.updateItemsLayout()
        }
        if animated {
            UIView.animate(withDuration: QSTabBarView.tabBarAnimatedDuration, animations: {
                switchItmeBlock()
            }, completion: completion)
        } else {
            switchItmeBlock()
            completion?(false)
        }
    }
    
    private func updateSelectIndicatorLayout() {
        
    }
    
    private func updateItemsLayout() {
        
    }
    
    private func fetchTabBarItem(with index: UInt) -> (UIView & QSTabBarItemProtocol)? {
        if index >= 0 && !(itemViews.isEmpty) && index < itemViews.count {
            return itemViews[Int(index)]
        }
        return nil
    }
    
    private func updateItemViewHighlight(with index: UInt) {
        if itemViews.count == 0 { return }
        for (idx, itemView) in itemViews.enumerated() {
            if index == idx {
                itemView.update(with: true)
            } else {
                itemView.update(with: false)
            }
        }
    }
    
    // MARK: action
    private func itemClickAction(with index: UInt) {
        let originIdx = self.selectIndex
        delegate?.tabBarView(self, willSelectItem: originIdx, targetIdx: index)
        switchItem(with: index, animated: indicatorAnimated) { (animted: Bool) -> Void in
            self.delegate?.tabBarView(self, didSelectItem: originIdx, targetIdx: index)
        }
    }
    
    private func itemDoubleClickAction(with index: UInt) {
        if self.selectIndex != index { return }
        delegate?.tabBarView(self, didSelectItemAgain: index, targetIdx: index)
    }
}
