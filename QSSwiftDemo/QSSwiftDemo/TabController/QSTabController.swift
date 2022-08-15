//
//  QSTabController.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation
import UIKit
import CoreAudio

enum QSTabSelectType {
    case QSTabSelectTypeDefault
    case QSTabSelectTypeTap // 点击tabBar选中
    case QSTabSelectTypeScroll // 滑动选中
    case QSTabSelectTypeForce // 手动选中
}

enum PGCVCStatus: UInt {
    case PGCVCStatusViewUnknown = 0
    case PGCVCStatusViewWillAppear = 1
    case PGCVCStatusViewDidAppear = 2
    case PGCVCStatusViewWillDisappear = 3
    case PGCVCStatusViewDidDisappear = 4
}

protocol QSTabControllerDataSource {
    
    func number(in qsController: QSTabController) -> Int
    func tabController(_ qsController: QSTabController, barItemView Index: UInt) -> UIView & QSTabBarItemProtocol
    func tabController(_ qsController: QSTabController, contentController index: UInt) -> UIViewController
    
}

protocol QSTabControllerDelegate {
    func defaultSelectIndex(in qsController: QSTabController) -> UInt
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
    
    private var tabBarView: UIView & QSTabBarViewProtocol
    private var customTabBarView: (UIView & QSTabBarViewProtocol)?
    lazy private var pageView: UIScrollView = UIScrollView()
    lazy private var loadedViewControllers: [UInt:UIViewController] = [:]
    private var numbersOfViewController: UInt = 0
    private var selectViewController: UIViewController?
    
    private var selectIndex: UInt = 0
    private var forceLoad: Bool = false
    private var transition: Bool = false
    private var tabVCStatus = PGCVCStatus.PGCVCStatusViewUnknown
    private static let tabBarViewAreaHeightDefault: Float = 44
    private static let tabControllerAnimationDuration = 0.25
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarViewInset: UIEdgeInsets = delegate?.tabBarViewInset(in: self) ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var tabBarViewAreaHeight = delegate?.heightForTabBarView(in: self) ?? QSTabController.tabBarViewAreaHeightDefault
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabVCStatus = PGCVCStatus.PGCVCStatusViewWillAppear
        updateStatus(status: PGCVCStatus.PGCVCStatusViewWillAppear, controller: self.selectViewController!, animated: animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabVCStatus = PGCVCStatus.PGCVCStatusViewDidAppear
        updateStatus(status: PGCVCStatus.PGCVCStatusViewDidAppear, controller: self.selectViewController!, animated: animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabVCStatus = PGCVCStatus.PGCVCStatusViewWillDisappear
        updateStatus(status: PGCVCStatus.PGCVCStatusViewWillDisappear, controller: self.selectViewController!, animated: animated)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabVCStatus = PGCVCStatus.PGCVCStatusViewDidDisappear
        updateStatus(status: PGCVCStatus.PGCVCStatusViewDidDisappear, controller: self.selectViewController!, animated: animated)
    }
    
    private func setupSubviews() {
        
    }
    
    private func updateStatus(status: PGCVCStatus, controller: UIViewController?, animated: Bool) {
        guard let vc = controller else {
            return
        }
        vc.pgc_vc_status = status
        switch status {
        case .PGCVCStatusViewWillAppear:
            vc.beginAppearanceTransition(true, animated: animated)
        case .PGCVCStatusViewDidAppear:
            vc.beginAppearanceTransition(false, animated: animated)
        case .PGCVCStatusViewWillDisappear:
            vc.endAppearanceTransition()
        case .PGCVCStatusViewDidDisappear:
            vc.endAppearanceTransition()
        default: break
        }
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
        reloadData(isForce: false)
    }
    public func scrollTo(_ index: UInt, animated: Bool) {
        if index == self.selectIndex || index >= self.numbersOfViewController {
            return
        }
        
    }
    
    public func contentViewController(with index: UInt) -> UIViewController? {
        return nil
    }
    
    private func reloadData(isForce: Bool) {
        
    }
    
    internal func selectTo(index: UInt, animated: Bool, selectType: QSTabSelectType) {
        if index < 0 || index >= self.numbersOfViewController {
            return
        }
        
        let lastSelectVC: UIViewController? = self.selectViewController
        let selectVC: UIViewController? = loadController(with: index)
        
        if self.tabVCStatus.rawValue < PGCVCStatus.PGCVCStatusViewWillDisappear.rawValue {
            updateStatus(status: PGCVCStatus.PGCVCStatusViewWillDisappear, controller: lastSelectVC, animated: false)
            if self.tabVCStatus.rawValue >= PGCVCStatus.PGCVCStatusViewWillAppear.rawValue {
                updateStatus(status: PGCVCStatus.PGCVCStatusViewWillAppear, controller: selectVC, animated: false)
            }
        }
        
        let oldSelectIndex = self.selectIndex
        self.selectIndex = index
        self.selectViewController = selectVC
        
        if self.transition {
            self.pageView.layer.removeAllAnimations()
        }
        
        delegate?.tabController(self, willDeselectTab: oldSelectIndex, type: selectType)
        delegate?.tabController(self, willSelectTab: index, type: selectType)
        
        let completionBlock = {
            (animated: Bool) -> Void in
            self.transition = false
            if self.tabVCStatus.rawValue < PGCVCStatus.PGCVCStatusViewDidDisappear.rawValue {
                self.updateStatus(status: PGCVCStatus.PGCVCStatusViewDidDisappear, controller: lastSelectVC, animated: animated)
                if self.tabVCStatus.rawValue >= PGCVCStatus.PGCVCStatusViewDidAppear.rawValue {
                    self.updateStatus(status: PGCVCStatus.PGCVCStatusViewDidAppear, controller: selectVC, animated: animated)
                }
            }
            self.delegate?.tabController(self, didDeselectTab: oldSelectIndex, type: selectType)
            self.delegate?.tabController(self, didSelectTab: index, type: selectType)
        }
        
        if animated {
            UIView.animate(withDuration: QSTabController.tabControllerAnimationDuration, animations: {
                self.transition = true
            }, completion: completionBlock)
        } else {
            completionBlock(false)
        }
    }
    
    private func loadController(with index: UInt) -> UIViewController? {
        if index < self.numbersOfViewController && self.dataSource != nil {
            let vc = self.dataSource?.tabController(self, contentController: index)
            if vc != nil {
                insertController(controller: vc!, to: index)
            }
            return vc
        }
        return nil
    }
    
    private func insertController(controller: UIViewController, to index: UInt) {
        if index >= 0 && index < self.numbersOfViewController {
            self.loadedViewControllers[index] = controller
            self.pageView .addSubview(controller.view)
        }
    }
    
    private func defaultSelectIndex() -> UInt {
        return delegate?.defaultSelectIndex(in: self) ?? 0
    }
    
    private func updateTabBar(with contentOffsetX: Float) {
        let contentSizeWidth = self.pageView.contentSize.width
        let width = self.view.bounds.width
        if contentSizeWidth < 0.1 || contentOffsetX < 0.1 || width < 0.1 {
            return
        }
        
        let currentIndex = contentOffsetX / Float(width)
        let leftIndex = floor(currentIndex)
        let rightIndex = ceil(currentIndex)
        
        let currentPointX = contentOffsetX
        let leftPointX = leftIndex * Float(width)
        let rightPointX = rightIndex * Float(width)
        
        let unitRelativePointX = rightPointX - leftPointX
        let currentRelativePointX = currentPointX - leftPointX
        
        var relativeProgress: Float = 0
        if unitRelativePointX > 0 || unitRelativePointX < 0 {
            relativeProgress = currentRelativePointX / unitRelativePointX;
        }
        
        let progress = contentOffsetX / Float(contentSizeWidth);
        self.tabBarView.update(with: progress, relativeProgress: relativeProgress, leftIndex: Int(leftIndex), rightIndex: Int(rightIndex))
    }
}

extension QSTabController : UIScrollViewDelegate, QSTabBarDelegate {
    
    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateTabBar(with: Float(scrollView.contentOffset.x))
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.bounds.width < 0.1 {
            return
        }
        let selectedIndex = UInt(scrollView.contentOffset.x / scrollView.bounds.width)
        tabBarView .scroll(to: selectedIndex, animated: false)
        selectTo(index: selectedIndex, animated: false, selectType: QSTabSelectType.QSTabSelectTypeScroll)
    }
    
    // MARK: QSTabBarDelegate
    public func numbersInQSTabBarView(_ tabBarView: UIView) -> UInt {
        return self.numbersOfViewController
    }
    
    public func tabBarView(_ tabBarView: UIView, index: UInt) -> UIView & QSTabBarItemProtocol {
        return dataSource?.tabController(self, barItemView: index) ?? QSTabBarItem()
    }
    
    public func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, willSelectItem originIdx: UInt, targetIdx: UInt) {
        
    }
    
    public func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, didSelectItem originIdx: UInt, targetIdx: UInt) {
        selectTo(index: targetIdx, animated: true, selectType: QSTabSelectType.QSTabSelectTypeTap)
    }
    
    public func tabBarView(_ tabBarView: UIView & QSTabBarViewProtocol, didSelectItemAgain originIdx: UInt, targetIdx: UInt) {
        delegate?.tabController(self, didSelectAgainTab: targetIdx, type: QSTabSelectType.QSTabSelectTypeTap)
    }
}


extension UIViewController {
    private static var pgc_vc_status_key: Bool = false
    var pgc_vc_status: PGCVCStatus {
        get {
            return objc_getAssociatedObject(self, &Self.pgc_vc_status_key) as? PGCVCStatus ?? PGCVCStatus.PGCVCStatusViewUnknown
        }
        set {
            objc_setAssociatedObject(self, &Self.pgc_vc_status_key, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
