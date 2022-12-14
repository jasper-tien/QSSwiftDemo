//
//  QSInitTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/20.
//

import Foundation
import UIKit

// 值类型没有便捷初始化器
// 类类型初始化器委托只能向上委托，不能和值类型一样横向委托

class QSInitTest: QSTestProtocol {
    func test_fire() {
        // 结构体类型的成员初始化器
        // 如果结构体类型中没有定义任何自定义初始化器，它会自动获得一个成员初始化器。
        // 不同于默认初始化器，结构体会接收成员初始化器即使它的存储属性没有默认值。
        let stru = InitStruct(width: 10, height: 10)

    }
}

// 初始化器
// 指定初始化器和便捷初始化器规则：
// 1、指定初始化器必须总是向上委托。
// 2、便捷初始化器必须总是横向委托。
class InitObject {
    var name: String
    var age: Int
    var sex: String = "男"
    internal var number: Int = 0
    // 指定初始化器
    // 指定初始化器是类的主要初始化器。
    // 指定的初始化器可以初始化所有那个类引用的属性并且调用合适的父类初始化器来继续这个初始化过程给父类链。
    // 类偏向于少量指定初始化器，并且一个类通常只有一个指定初始化器。
    // 每个类至少得有一个指定初始化器。
    
    // 指定初始化器必须从它的直系父类调用指定初始化器。
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    required init () {
        self.name = "tianmaotao"
        self.age = 0
    }
    
    // 便捷初始化器
    // 你可以在相同的类里定义一个便捷初始化器来调用一个指定的初始化器作为便捷初始化器来给指定初始化器设置默认形式参数
    
    // 便捷初始化器必须从相同的类里调用另一个初始化器。
    // 便捷初始化器最终必须调用到一个指定初始化器。
    convenience init(name: String) {
        self.init(name: name, age: 22)
    }
    
    // 可失败初始化器
    // 通过在 init 关键字后面添加问号( init? )来写。
    // 严格来讲，初始化器不会有返回值。相反，它们的角色是确保在初始化结束时， self 能够被正确初始化。虽然你写了 return nil 来触发初始化失败，但是你不能使用 return 关键字来表示初始化成功了。
    init?(with name: String?) {
        if name == nil {
            return nil
        }
        self.name = ""
        self.age = 0
    }
    
    func printFunc() {
        let str = name + sex
        print("\(str)")
    }
}

class SubInitObject : InitObject {
    var isSub: Bool
    
    // 必要初始化器
    // 在类的初始化器前添加 required  修饰符来表明所有该类的子类都必须实现该初始化器
    // 在重写父类的必要初始化器时，不需要添加 override 修饰符
    required init() {
        self.isSub = true
        super.init()
    }
    
    // 两段式初始化
    // 第一个阶段，每一个存储属性被引入类为分配了一个初始值。(初始化器向上调用父类初始化器，值到最顶部，此时认为完全初始化，第一阶段完成)
    // 第二个阶段，每个类都有机会在新的实例准备使用之前来定制它的存储属性。
    
    // 安全检查 1：
    // 指定初始化器必须保证在向上委托给父类初始化器之前，其所在类引入的所有属性都要初始化完成。
    // 安全检查 2：
    // 指定初始化器必须先向上委托父类初始化器，然后才能为继承的属性设置新值。
    // 如果不这样做，指定初始化器赋予的新值将被父类中的初始化器所覆盖。
    // 安全检查 3：
    // 便捷初始化器必须先委托同类中的其它初始化器，然后再为任意属性赋新值（包括同类里定义的属性）。
    // 如果没这么做，便捷构初始化器赋予的新值将被自己类中其它指定初始化器所覆盖。
    // 安全检查 4：
    // 初始化器在第一阶段初始化完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用 self 作为值。
    // 直到第一阶段结束类实例才完全合法。属性只能被读取，方法也只能被调用，直到第一阶段结束的时候，这个类实例才被看做是合法的。

    
    // 子类指定初始化器必须调用父类指定初始化器
    init(name: String, age: Int, isSub: Bool) {
        self.isSub = isSub
//        self.age = 18 // (安全检查 2：and 安全检查 4)error:'self' used in property access 'age' before 'super.init' call
        super.init(name: name, age: age)
        self.age = 18
//        self.isSub = isSub // (安全检查 1)error:Property 'self.isSub' not initialized at super.init call
    }
    
    convenience init(age: Int) {
//        self.age = 10 // (安全检查 3)error:'self' used before 'self.init' call or assignment to 'self'
        self.init(name: "tian", age: age)
    }
    
    // 初始化器的重写和继承
    // Swift 的子类不会默认继承父类的初始化器
    // 可以用过加override关键字， 重写父类初始化器。
    // 如果你写了一个匹配父类便捷初始化器的子类初始化器，父类的便捷初始化器将永远不会通过你的子类直接调用。
    // 当提供一个匹配的父类便捷初始化器的实现时，你不用写 override 修饰符。
    override init(name: String, age: Int) {
        self.isSub = true
        super.init(name: name, age: age)
    }
    
    
    // 初始化器的自动继承
    // 在特定的情况下父类初始化器是可以被自动继承的。假设你为你子类引入的任何新的属性都提供了默认值。
    // 规则1:
    // 如果你的子类没有定义任何指定初始化器，它会自动继承父类所有的指定初始化器。
    // 规则2:
    // 如果你的子类提供了所有父类指定初始化器的实现——要么是通过规则1继承来的，要么通过在定义中提供自定义实现的.
    // 那么它自动继承所有的父类便捷初始化器。

    //重写可失败初始化器
    // 你可以在子类里重写父类的可失败初始化器。就好比其他的初始化器。
    // 或者，你可以用子类的非可失败初始化器来重写父类可失败初始化器。这样允许你定义一个初始化不会失败的子类，尽管父类的初始化允许失败。
    // 注意如果你用非可失败的子类初始化器重写了一个可失败初始化器，向上委托到父类初始化器的唯一办法是强制展开父类可失败初始化器的结果。
    override init(with name: String?) {
        var n = ""
        if name != nil {
            n = name!
        }
        self.isSub = true
        super.init(with: n)!
    }
}


struct InitStruct {
    var width: Float = 0
    var height: Float = 0
    init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    // 值类型的初始化器委托
    // 初始化器可以调用其他初始化器来执行部分实例的初始化。
    // 这个过程，就是所谓的初始化器委托，避免了多个初始化器里冗余代码。
    // 当你写自己自定义的初始化器时可以使用 self.init 从相同的值类型里引用其他初始化器
    init(size: Size) {
        let width: Float = size.width
        let height: Float = size.height
        self.init(width: width, height: height)
    }
}

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
