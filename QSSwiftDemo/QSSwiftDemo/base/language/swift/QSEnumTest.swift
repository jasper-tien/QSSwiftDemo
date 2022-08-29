//
//  QSEnumTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/10.
//

import Foundation

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// 遵循CaseIterable协议，提供遍历功能
enum QSType : CaseIterable {
    case type1
    case type2
}

//关联值
enum QSBarcode{
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// 原始值
enum QSType1 : Int {
    case type1 = 1
    case type2 = 2
}

//隐式指定的原始值
enum QSType2 : Int {
    case type1 = 1, type2, type3, type4
}

class EnumTest {
    var point: CompassPoint?
    var point1 = CompassPoint.east
    func test_fire(_ point: CompassPoint) {
        // 当能推断出self.point类型时，用一个点语法把它设定成不同的CompassPoint值
        self.point = .south
        
        // 使用 Switch 语句来匹配枚举值
        switch point {
        case .north:
            self.point = .north
        case .south:
            self.point = .south
        case .east:
            self.point = .east
        case .west:
            self.point = .west
        }
        
        // 遍历枚举情况（case）
        let caseCount = QSType.allCases.count
        for type in QSType.allCases {
            print(type)
        }
        
        //关联值
        var productBarcode = QSBarcode.upc(10, 1, 1, 1)
        productBarcode = .qrCode("tianmaotao")
        switch productBarcode {
        case .upc(let num1, let num2, let num3, let num4):
            print("num1:\(num1) num2:\(num2) num3:\(num3) num4:\(num4)")
        case .qrCode(let code):
            print("code:\(code)")
        }
        //如果对于一个枚举成员的所有的相关值都被提取为常量，或如果都被提取为变量，为了简洁，你可以用一个单独的 var或 let在成员名称前标注：
        switch productBarcode {
        case let .upc(num1, num2, num3, num4):
            print("num1:\(num1) num2:\(num2) num3:\(num3) num4:\(num4)")
        case let .qrCode(code):
            print("code:\(code)")
        }
        
        // 原始值
        let type1_1 = QSType1.type1
        let type1_1_value = type1_1.rawValue
        
        //隐式指定的原始值
        let type2_1 = QSType2.type3
        let type2_1_value = type2_1.rawValue
        
        // 从原始值初始化
        //如果你用原始值类型来定义一个枚举，那么枚举就会自动收到一个可以接受原始值类型的值的初始化器（叫做 rawValue的形式参数）然后返回一个枚举成员或者 nil 
        if let type2_2 = QSType2(rawValue: 2) {
            print("\(type2_2)")
        }
    }
}
