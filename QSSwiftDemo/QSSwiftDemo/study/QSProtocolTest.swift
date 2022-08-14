//
//  QSProtocolTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/14.
//

import Foundation
import UIKit

class QSProtocolTest : QSTestProtocol {
    public func test_fire() {
        let cat = QSProtocolCat(name: "cat")
        cat.print_func()
        //有条件地遵循协议
        let ob1 = QSProtocolDog()
        ob1.actinFunc()
        let ob2 = QSProtocolDog()
        let array = [ob1, ob2]
        array.descPrint()
        
    }
}

// 若一个类拥有父类，将这个父类名放在其采纳的协议名之前，并用逗号分隔
// class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//
// }

// 属性要求
// 协议可以要求所有遵循该协议的类型提供特定名字和类型的实例属性或类型属性。
// 协议并不会具体说明属性是储存型属性还是计算型属性——它只具体要求属性有特定的名称和类型。
// 协议同时要求一个属性必须明确是可读的或可读的和可写的。
// 若协议要求一个属性为可读和可写的，那么该属性要求不能用常量存储属性或只读计算属性来满足。
// 若协议只要求属性为可读的，那么任何种类的属性都能满足这个要求，而且如果你的代码需要的话，该属性也可以是可写的。

protocol QSProtocol {
    var name: String { get }
    var age: Int { get set }
    // 类型属性
    static var className: String { get set }
    // 初始化器
    // 实现类中必须使用required关键字
    init(name: String)
    func print_func()
}

// 提供默认实现
// 你可以使用协议扩展来给协议的任意方法或者计算属性要求提供默认实现。
// 如果遵循类型给这个协议的要求提供了它自己的实现，那么它就会替代扩展中提供的默认实现。
// 实现类不用强制实现这个方法，也不用用可选链调用
extension QSProtocol {
    func print_func() {
        print("默认实现")
    }
}


// 协议组合
// 协议组合使用 SomeProtocol & AnotherProtocol 的形式。你可以列举任意数量的协议，用和符号连接（ & ），使用逗号分隔。除了协议列表，协议组合也能包含类类型，这允许你标明一个需要的父类。

// 协议遵循的检查
// 使用类型转换中描述的 is 和 as 运算符来检查协议遵循，还能转换为特定的协议。检查和转换协议的语法与检查和转换类型是完全一样的：
// 如果实例遵循协议is运算符返回 true 否则返回 false ；
// as? 版本的向下转换运算符返回协议的可选项，如果实例不遵循这个协议的话值就是 nil ；
// as! 版本的向下转换运算符强制转换协议类型并且在失败是触发运行时错误。

class QSProtocolCat: QSProtocol {
    var name: String = ""
    var age: Int = 0
    static var className: String = "QSProtocolCat"
    var array: [AnyObject] = []
    
    required init(name: String) {
        self.name = name
    }
    
    func config(cat: QSProtocolCat & QSProtocol) {
        name = cat.name
        age = cat.age
    }
    
    func print_func() {
        for object in array {
            if !(object is QSProtocol) {
                continue
            }
            if let tmp = object as? QSProtocol {
                print("\(tmp.name)")
            }
            let tmp = object as! QSProtocol
            print("QSProtocolCat\(tmp.name)")
        }
    }
}

protocol QSActionProtocol {
    func descPrint()
}

class QSProtocolDog {
    
}

// 在扩展里添加协议遵循
extension QSProtocolDog: QSActionProtocol {
    func descPrint() {
        print("dog")
    }
}

// 有条件地遵循协议
// 泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。
// 你可以通过在扩展类型时列出限制让泛型类型有条件地遵循某协议。在你采纳协议的名字后面写泛型 where 分句。
extension Array: QSActionProtocol where Element: QSActionProtocol {
    func descPrint() {
        _ = self.map { (action: QSActionProtocol) in
            action.descPrint()
        }
    }
}


// 类专用的协议
// 通过添加 AnyObject 关键字到协议的继承列表，你就可以限制协议只能被类类型采纳（并且不是结构体或者枚举）。
protocol SomeClassOnlyProtocol: AnyObject {
    // class-only protocol definition goes here
}

// 协议扩展
// 协议可以通过扩展来提供方法和属性的实现以遵循类型。这就允许你在协议自身定义行为，而不是在每一个遵循或者在全局函数里定义。
extension QSActionProtocol {
    func actinFunc() {
        print("test")
    }
}
