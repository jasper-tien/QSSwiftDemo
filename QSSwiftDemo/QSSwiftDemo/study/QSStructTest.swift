//
//  QSStructTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/10.
//

import Foundation

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
    }
}

/// 属性包装
@propertyWrapper
struct WrapperStruct {
    private var number: Int = 0
    var wrappedValue: Int { // 必须包含wrappedValue这个计算属性
        get { return number }
        set { number = min(newValue, 12) }
    }
}
struct wrapperStructTest {
    @WrapperStruct var s1: Int //
    @WrapperStruct var s2: Int
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
