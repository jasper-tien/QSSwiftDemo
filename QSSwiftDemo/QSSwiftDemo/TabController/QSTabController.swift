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
    
    private var forceLoad: Bool = false
    var isForceLoad: Bool {
        return forceLoad
    }
    private var selectIndex: UInt = 0
    var selectingIndex: UInt {
        return selectIndex
    }
    var selectViewController: UIViewController?  {
        return nil
    }
    var tabBarView: QSTabBarViewProtocol? {
        return nil
    }
    var pageView: UIScrollView? {
        return nil
    }
    
    public func reloadData() {
        
    }
    
    public func scrollTo(_ index: UInt, animated: Bool) {
        
    }
    
    public func contentViewController(with index: UInt) -> UIViewController? {
        return nil
    }
}
