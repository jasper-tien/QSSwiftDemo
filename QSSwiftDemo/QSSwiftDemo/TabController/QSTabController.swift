//
//  QSTabController.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation
import UIKit

enum QSTabSelectType {
    case QSTabSelectTypeDefault
    case QSTabSelectTypeTap // 点击tabBar选中
    case QSTabSelectTypeScroll // 滑动选中
    case QSTabSelectTypeForce // 手动选中
}

enum PGCVCStatus {
    case PGCVCStatusViewUnknown
    case PGCVCStatusViewWillAppear
    case PGCVCStatusViewDidAppear
    case PGCVCStatusViewWillDisappear
    case PGCVCStatusViewDidDisappear
}

protocol QSTabControllerDataSource {
    
    func number(in qsController: QSTabController) -> Int
    func tabController(_ qsController: QSTabController, barItemView Index: UInt) -> QSTabBarItemProtocol
    func tabController(_ qsController: QSTabController, contentController index: UInt) -> UIViewController
    
}

protocol QSTabControllerDelegate {
    func defaultSelectIndex(in qsController: QSTabController)
    func indicatorHidden(in qsController: QSTabController) -> Bool
    
    // Variable height & width support
    
    func heightForTabBarView(in qsController: QSTabController) -> Float
    func tabBarItemSpacing(in qsController: QSTabController) -> Float
    func indicatorHeight(in qsController: QSTabController) -> Float
    func tabBarViewInset(in qsController: QSTabController) -> UIEdgeInsets
    func tabBarViewContentInset(in qsController: QSTabController) -> UIEdgeInsets
    
    // Switch customization
    
    func tabController(_ qsController: QSTabController, willSelectTab index: UInt, type: QSTabSelectType)
    func tabController(_ qsController: QSTabController, didSelectTab index: UInt, type: QSTabSelectType)
    func tabController(_ qsController: QSTabController, didSelectAgainTab index: UInt, type: QSTabSelectType)
    func tabController(_ qsController: QSTabController, willDeselectTab index: UInt, type: QSTabSelectType)
    func tabController(_ qsController: QSTabController, didDeselectTab index: UInt, type: QSTabSelectType)
}

public class QSTabController : UIViewController {
    var dataSource: QSTabControllerDataSource?
    var delegate: QSTabControllerDelegate?
    public var isForceLoad: Bool {
        return forceLoad
    }
    public var selectingIndex: UInt {
        return selectIndex
    }
    
    // MARK: private
    
    private var tabBarView: QSTabBarViewProtocol
    private var customTabBarView: QSTabBarViewProtocol?
    lazy private var pageView: UIScrollView = UIScrollView()
    lazy private var loadedViewControllers: [Int:UIViewController] = [:]
    private var numbersOfViewController: UInt = 0
    private var selectViewController: UIViewController?
    
    private var selectIndex: UInt = 0
    private var forceLoad: Bool = false
    private var transition: Bool = false
    private var tabVCStatus = PGCVCStatus.PGCVCStatusViewUnknown
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QSTabController {
    
    private func setSubviews() {
        if customTabBarView != nil {
            tabBarView = customTabBarView!
        } else {
            tabBarView = QSTabBarView()
            tabBarView .configDelegate(self)
        }
    }
    
    public func reloadData() {
        
    }
    public func scrollTo(_ index: UInt, animated: Bool) {
        
    }
    
    public func contentViewController(with index: UInt) -> UIViewController? {
        return nil
    }
}

extension QSTabController : UIScrollViewDelegate, QSTabBarDelegate {
    
    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    // MARK: QSTabBarDelegate
    public func numbersInQSTabBarView(_ tabBarView: UIView) -> UInt {
        return 0
    }
    
    public func tabBarView(_ tabBarView: UIView, willSelectItem originIdx: UInt, targetIdx: UInt) {
        
    }
    
    public func tabBarView(_ tabBarView: UIView, didSelectItem originIdx: UInt, targetIdx: UInt) {
        
    }
    
    public func tabBarView(_ tabBarView: UIView, didSelectItemAgain originIdx: UInt, targetIdx: UInt) {
        
    }
    
}
