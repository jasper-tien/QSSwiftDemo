//
//  QSTabTestController.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/16.
//

import UIKit

class QSTabModel {
    let tabBarItem: QSTabBarItem
    let contentController: UIViewController
    
    init(tabBarItem: QSTabBarItem, contentController: UIViewController) {
        self.tabBarItem = tabBarItem
        self.contentController = contentController
    }
}

class QSTabTestController: UIViewController, QSTabControllerDataSource, QSTabControllerDelegate {
    
    var tabModels: [QSTabModel] = []
    private lazy var tabController = QSTabController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let bgColors: [Array] = [
            [UIColor.purple, "紫色"],
            [UIColor.orange, "橘色"],
            [UIColor.green, "绿色"],
            [UIColor.systemPink, "粉色"],
            [UIColor.lightGray, "灰色"],
        ]
        for (index, value) in bgColors.enumerated() {
            let barItem = QSTabBarItem(frame: CGRect())
            barItem.config(title: "第 \(index) tab", subtitle: nil)
            
            let contentVC = UIViewController()
            contentVC.view.backgroundColor = value[0] as? UIColor
            contentVC.title = value[1] as? String
        
            let model = QSTabModel(tabBarItem: barItem, contentController: contentVC)
            self.tabModels.append(model)
        }
        
        tabController.dataSource = self
        tabController.delegate = self
        self.addChild(tabController)
        self.view.addSubview(tabController.view)
        tabController.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabController.view.frame = self.view.bounds
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension QSTabTestController {
    
    // MARK: QSTabControllerDataSource
    func number(in tabController: QSTabController) -> Int {
        return tabModels.count
    }
    
    func tabController(_ tabController: QSTabController, barItemView index: Int) -> UIView & QSTabBarItemProtocol {
        if index >= tabModels.count {
            return QSTabBarItem()
        }
        return tabModels[Int(index)].tabBarItem
    }
    
    func tabController(_ tabController: QSTabController, contentController index: Int) -> UIViewController {
        if index >= tabModels.count {
            return UIViewController()
        }
        return tabModels[Int(index)].contentController
    }
    
    // MARK: QSTabControllerDelegate
    func defaultSelectIndex(in tabController: QSTabController) -> Int {
        return 0
    }
    func indicatorHidden(in tabController: QSTabController) -> Bool {
        return false
    }
    
    // Variable height & width support
    
    func heightForTabBarView(in tabController: QSTabController) -> CGFloat {
        return 44
    }
    func tabBarItemSpacing(in tabController: QSTabController) -> CGFloat {
        10
    }
    func indicatorHeight(in tabController: QSTabController) -> CGFloat {
        return 5
    }
    func tabBarViewInset(in tabController: QSTabController) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func tabBarViewContentInset(in tabController: QSTabController) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func tabController(_ tabController: QSTabController, willSelectTab index: Int, type: QSTabSelectType) {
        
    }
    func tabController(_ tabController: QSTabController, didSelectTab index: Int, type: QSTabSelectType) {
        
    }
    func tabController(_ tabController: QSTabController, didSelectAgainTab index: Int, type: QSTabSelectType) {
        
    }
    func tabController(_ tabController: QSTabController, willDeselectTab index: Int, type: QSTabSelectType) {
        
    }
    func tabController(_ tabController: QSTabController, didDeselectTab index: Int, type: QSTabSelectType) {
        
    }
    
}
