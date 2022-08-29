//
//  QSGenericityTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/28.
//

import Foundation

class QSGenericityTest: QSTestProtocol {
    func test_fire() {
        var stack: Stack<String> = Stack()
        stack.push("tian")
        stack.push("mao")
        stack.push("tao")
        
        if let last = stack.topItem {
            print("\(last)")
        }
        
    }
}

// 泛型函数
// 后面跟着占位类型名（T），并用尖括号括起来（<T>），这个尖括号告诉 Swift 那个 T 是函数定义内的一个占位类型名，因此 Swift 不会去查找名为 T的实际类型。
// T 的实际类型由每次调用函数来决定。
// 你可提供多个类型参数，将它们都写在尖括号中，用逗号分开。
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let c = a;
    a = b;
    b = c;
}

// 泛型类型
struct Stack<Element: Equatable> {
    private var items: [Element] = [Element]()
    
    mutating public func push(_ item: Element) {
        items.append(item)
    }
    
    mutating public func pop(_ item: Element) -> Element? {
        return items.removeLast()
    }
}

// 泛型扩展
// 当对泛型类型进行扩展时，你并不需要提供类型参数列表作为定义的一部分。原始类型定义中声明的类型参数列表在扩展中可以直接使用
extension Stack {
    var topItem: Element? {
        return  items.isEmpty ? nil :  items[items.count - 1]
    }
}

// 类型约束语法
// 在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束。
// func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) { 这里是泛型函数的函数体部分 }

// PS:
// 所有的 Swift 标准类型自动支持 Equatable 协议。
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// 关联类型
// 定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。
// 关联类型为协议中的某个类型提供了一个占位符名称，其代表的实际类型在协议被遵循时才会被指定。
// 关联类型通过 associatedtype 关键字来指定。
protocol Container {
    // 给关联类型添加约束
    // 也可以在协议里给关联类型添加约束来要求遵循的类型满足约束，比如：ItemType: Equatable
    associatedtype ItemType: Equatable
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType? { get }
}
extension Stack: Container {
    // Container 协议的实现部分
    // 指定 ItemType 为 Element 类型，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Element 类型
    // 由于 Swift 的类型推断，实际上在 Stack 的定义中不需要声明 ItemType 为 Container
    typealias ItemType = Element
    
    mutating func append(_ item: ItemType) {
        self.push(item)
    }
    
    var count: Int {
        return self.items.count
    }
    
    subscript(i: Int) -> ItemType? {
        if i >= items.count {
            return nil
        }
        return self.items[i]
    }
}

// 在关联类型约束里使用协议
// 协议可以作为它自身的要求出现。
// 例如:
// 有一个协议细化了 Container 协议，添加了一个suffix(_:) 方法。suffix(_:) 方法返回容器中从后往前给定数量的元素，并把它们存储在一个 Suffix 类型的实例里(并不知道容器的具体内容)
protocol SuffixableContainer: Container {
    
    //Suffix 拥有两个约束：
    // 它必须遵循 SuffixableContainer 协议（就是当前定义的协议）
    // 以及它（泛型）的 Item 类型必须是和容器里的 Item 类型相同
    associatedtype Suffix: SuffixableContainer where Suffix.ItemType == ItemType
    func suffix(_ size: Int) -> Suffix
}
extension Stack: SuffixableContainer {
    typealias Suffix = Stack<Element>
    func suffix(_ size: Int) -> Suffix {
        var result = Stack()
        for index in (count - size)..<size {
            result.append(items[index])
        }
        return result
    }
}

// 泛型 Where 语句
// 你可以在函数体或者类型的大括号之前添加 where 分句

// 函数被调用时才能确定它们的具体类型，函数被调用时才能确定它们的具体类型

// 这个函数的类型参数列表还定义了对两个类型参数的要求：
// C1 必须符合 Container 协议（写作 C1: Container）。
// C2 必须符合 Container 协议（写作 C2: Container）。
// C1 的 Item 必须和 C2 的 Item 类型相同（写作 C1.Item == C2.Item）。
// C1 的 Item 必须符合 Hashable 协议（写作 C1.Item: Hashable）。

// 前两个要求定义在函数的类型形式参数列表里，后两个要求定义在了函数的泛型 where 分句中。
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Hashable {
    // 检查两个容器含有相同数量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // 检查每一对元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}


// 具有泛型 Where 子句的扩展
// 返回一个所有元素都遵循Hashable的字典
extension Stack where Element: Hashable {
    func fetchAllItem() -> [Int:Element] {
        var ret = [Int:Element]()
        for (index, value) in items.enumerated() {
            ret[index] = value
        }
        return ret
    }
}

