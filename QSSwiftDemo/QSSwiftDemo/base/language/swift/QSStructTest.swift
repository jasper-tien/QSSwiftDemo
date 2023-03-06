//
//  QSStructTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/10.
//

import Foundation

struct StructTest : QSTestProtocol {
    func test_fire() {
        
    }
}

struct Point {
    var x: Float = 0
    var y: Float = 0
    
    func func1(_ newX: Float, _ newY: Float) {
//        x = newX error
//        y = newY error
    }
    mutating func func2(_ newX: Float, _ newY: Float) {
        x = newX
        y = newY
    }
    mutating func func3(_ newX: Float, _ newY: Float) {
        self = Point(x: newX, y: newY)
    }
}
struct Size {
    var width: Float = 0
    var height: Float = 0
}
struct Rect {
    var point = Point()
    var size = Size()
    
    // 计算属性
    var center: Point {
        get {
            let centerX = point.x + size.width / 2
            let centerY = point.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            point.x = newCenter.x - size.width / 2
            point.y = newCenter.y - size.height / 2
        }
//        // 简写setter
//        set {
//            point.x = newValue.x - size.width / 2
//            point.y = newValue.y - size.height / 2
//        }
    }
    
    //简写设置器（setter）声明
    //如果一个计算属性的设置器没有为将要被设置的值定义一个名字，那么他将被默认命名为 newValue。
    var maxX: Point {
        get {
            let maxX = point.x + size.width
            let maxY = point.y + size.height
            return Point(x: maxX, y: maxY)
        }
        set {
            point.x = newValue.x - size.width
            point.y = newValue.y - size.height
        }
    }
    
    // 只读计算属性
    // 一个有读取器但是没有设置器的计算属性就是所谓的只读计算属性
    var width: Float {
        get {
            return size.width
        }
    }
    // 也可以通过去掉 get 关键字和他的大扩号来简化只读计算属性的声明
    var height: Float {
        return size.height
    }
    
    // 类型属性
    // 使用 static 关键字来声明类型属性。
    // 对于类类型的计算类型属性，你可以使用 class 关键字来允许子类重写父类的实现。
    static var name = "Rect"
    static var nameString: String {
        return name
    }
}

/// 属性包装
/// 属性包装给代码之间添加了一层分离层，它用来管理属性如何存储数据以及代码如何定义属性。
/// 定义了 wrappedValue 计算属性
/// @WrapperStruct 修饰的属性类型必须和wrappedValue一致
@propertyWrapper
struct WrapperStruct {
    private var number: Int = 0
    var wrappedValue: Int { // 必须包含wrappedValue这个计算属性
        get { return number }
        set { number = min(newValue, 12) }
    }
}

// 结构体和枚举是值类型。默认情况下，值类型属性不能被自身的实例方法修改。
// 在异变方法里可以指定自身
struct wrapperStructTest {
    @WrapperStruct var s1: Int //
    @WrapperStruct var s2: Int
    mutating func test() {
        print("\(self.s1)"); // 0
        s1 = 10
        print("\(self.s1)"); // 10
        s1  = 30
        print("\(self.s1)"); // 12
    }
}

@propertyWrapper
struct SmallNumber {
    private var numMax: Int
    private var num: Int
    var wrappedValue: Int {
        get { return num }
        set { num = min(numMax, newValue) }
    }
    init() {
        numMax = 12
        num = 0
    }
    init(wrappedValue: Int) {
        numMax = 12
        num = min(wrappedValue, numMax)
    }
    init(wrappedValue: Int, numMax: Int) {
        self.numMax = numMax
        num = min(wrappedValue, numMax)
    }
}
struct wrapperStructTest1 {
    @SmallNumber var s1: Int = 1
}
struct wrapperStructTest2 {
    @SmallNumber(wrappedValue: 20, numMax: 12) var s1: Int
}

// 类型属性
struct SomeStructure {
    static var name: String = "tianmaotao"
    static var nameStr: String {
        get { return name }
        set { name = newValue }
    }
}
