//
//  QSExtensionTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/14.
//

import Foundation

class QSExtensionTest: QSTestProtocol {
    func test_fire() {
        let city = QSCity(name: "Shanghai")
        city.printFunc()
    }
}

// Swift的扩展没有名字，扩展可以:
// 1、添加计算实例属性和计算类型属性；
// 2、定义实例方法和类型方法；
// 3、提供新初始化器；
// 4、定义下标；
// 5、定义和使用新内嵌类型；
// 6、使现有的类型遵循某协议
// 7、扩展协议，提供默认实现

class QSCity {
    var name: String
    var persons: Int = 0
    init(name: String) {
        self.name = name
    }
}
 
protocol QSCityProtocol {
    func travel()
    func action()
}

extension QSCity {
    // 计算实例属性
    var station: String {
        "\(name)车站"
    }
    
    // 实例方法
    func printFunc() {
        print("name:\(self.name) station:\(self.station)")
    }
    
    convenience init(name: String, persons: Int) {
        self.init(name: name)
        self.persons = persons
    }
}

// 扩展已有类，实现遵循的协议功能
extension QSCity: QSCityProtocol {
    func travel() {
        print("travel")
    }
    
    func road() {
        print("road")
    }
}

// 有条件地遵循协议
extension Array where Element: QSCityProtocol {
    func descPrint() {
        _ = self.map { (action: QSCityProtocol) in
            action.action()
        }
    }
}

// 扩展协议，提供默认实现
extension QSCityProtocol {
    func action() {
        print("action")
    }
    
    func policy() {
        print("policy")
    }
}

