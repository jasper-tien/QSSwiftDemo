//
//  QSHomeController.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/29.
//

import UIKit

public class QSHomeController: UIViewController {
    private lazy var tabModels = [QSHomeTabModel]()
    private lazy var navigationBar: QSHomeNavigationBar = {
        let navigationBar = QSHomeNavigationBar(frame: CGRect())
        navigationBar.backgroundColor = UIColor.white
        return navigationBar
    }()
    
    private lazy var tabController: QSTabController = {
        let tabController = QSTabController()
        return tabController
    }()
    
    private lazy var topLineView: UIView = {
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor.lightGray
        return topLineView
    }()
    
    // MARK: override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        buildModels()
        
        view.addSubview(navigationBar)
        testEntrance()
        
        tabController.delegate = self
        tabController.dataSource = self
        view.addSubview(tabController.view)
        self.addChild(tabController)
        tabController.reloadData()
        
        tabController.topTabBarView.addSubview(topLineView)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 80
        )
        tabController.view.frame = CGRect(
            x: 0,
            y: navigationBar.frame.maxY,
            width: view.frame.width,
            height: view.frame.height - navigationBar.frame.minY
        )
        topLineView.frame = CGRect(
            x: 0,
            y: tabController.topTabBarView.bounds.height - 1,
            width: tabController.topTabBarView.bounds.width,
            height: 1
        )
    }
    
    // private methods
    private func buildModels() {
        let items: [Dictionary<String, String>] = [
            ["class" : "QSSwiftDemo.QSTableTestController", "title" : "火之晨曦"],
            ["class" : "QSSwiftDemo.QSTestPageController", "title" : "悼亡者之瞳"],
            ["class" : "QSSwiftDemo.QSTestPageController", "title" : "黑月之潮"],
            ["class" : "QSSwiftDemo.QSTestPageController", "title" : "奥丁之渊"],
            ["class" : "QSSwiftDemo.QSTestPageController", "title" : "悼亡者的归来"],
        ]
        for (_, value) in items.enumerated() {
            let barItem = QSTabBarItem(frame: CGRect())
            if let title = value["title"] {
                barItem.config(title: "\(title)", subtitle: nil)
                barItem.config(titleFont: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular), subtitleFont: nil)
            }
            var contentVC: UIViewController? = nil
            if let cls = value["class"] {
                 if let classType = NSClassFromString(cls) {
                     if let vcClassType = classType as? UIViewController.Type {
                         contentVC = vcClassType.init() 
                     }
                 }
            }
            if contentVC != nil {
                let model = QSHomeTabModel(tabBarItem: barItem, contentController: contentVC!)
                self.tabModels.append(model)
            }
        }
    }
    
    private func testEntrance() {
        let test = QSAlgorithmTest()
        test.fireFunc()
    }
}

extension QSHomeController: QSTabControllerDataSource, QSTabControllerDelegate {
    // MARK: QSTabControllerDataSource
    public func number(in tabController: QSTabController) -> Int {
        return tabModels.count
    }
    
    public func tabController(_ tabController: QSTabController, barItemView index: Int) -> UIView & QSTabBarItemProtocol {
        if index >= tabModels.count {
            return QSTabBarItem()
        }
        return tabModels[Int(index)].tabBarItem
    }
    
    public func tabController(_ tabController: QSTabController, contentController index: Int) -> UIViewController {
        if index >= tabModels.count {
            return UIViewController()
        }
        return tabModels[Int(index)].contentController
    }
    
    // MARK: QSTabControllerDelegate
    public func defaultSelectIndex(in tabController: QSTabController) -> Int {
        return 0
    }
    public func indicatorHidden(in tabController: QSTabController) -> Bool {
        return false
    }
    
    // Variable height & width support
    
    public func heightForTabBarView(in tabController: QSTabController) -> CGFloat {
        return 44
    }
    public func tabBarItemSpacing(in tabController: QSTabController) -> CGFloat {
        20
    }
    public func indicatorHeight(in tabController: QSTabController) -> CGFloat {
        return 3
    }
    public func tabBarViewInset(in tabController: QSTabController) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
    }
    public func tabBarViewContentInset(in tabController: QSTabController) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    public func tabController(_ tabController: QSTabController, willSelectTab index: Int, type: QSTabSelectType) {
        
    }
    public func tabController(_ tabController: QSTabController, didSelectTab index: Int, type: QSTabSelectType) {
        
    }
    public func tabController(_ tabController: QSTabController, didSelectAgainTab index: Int, type: QSTabSelectType) {
        
    }
    public func tabController(_ tabController: QSTabController, willDeselectTab index: Int, type: QSTabSelectType) {
        
    }
    public func tabController(_ tabController: QSTabController, didDeselectTab index: Int, type: QSTabSelectType) {
        
    }
}


class QSHomeTabModel {
    let tabBarItem: QSTabBarItem
    let contentController: UIViewController
    
    init(tabBarItem: QSTabBarItem, contentController: UIViewController) {
        self.tabBarItem = tabBarItem
        self.contentController = contentController
    }
}

class QSHomeNavigationBar: UIView {
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "PingFangSC-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
        titleLabel.text = "Home"
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(
            x: 0,
            y:max(0, self.frame.height - 44),
            width: self.frame.width,
            height: 44
        )
    }
}
