//
//  QSClaseStruct.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/4/3.
//

import UIKit

class QSTestObject : NSObject {
    func test_fire() {
        var point = Point(x: 9, y: 0)
        var person = Person()
        let person1 = person
        let person2 = Person()
        point.x = 10
        point.y = 90
        person.name = "xiaoming"
        person.sex = "男"
        person.point = point
        person.point.x = 50
        
        var point1 = Point(x: 40, y: 10)
        if person === person1 {
            
        }
        if person !== person2 {
            
        }
        
        print("before:\(person.speak)")
        person.money = 10
        
        var structTest = wrapperStructTest()
        structTest.s1 = 100
        
        var structTest1 = wrapperStructTest1()
        
        SomeStructure.name = "tianmaotao"
        
        let man = ManPerson()
        man.nameStr
        man.money = 10
        
        let io = InitObject("tianmaotao")
        
        let subIO = SubInitObject("tianmaotao")
        subIO.printDesc()
        subIO.update(name: "tmt", sex: "nan", age: 18)
        let desc = subIO.desc
        
        var p1 = Point(with: 1, with: 1)
        
        let car = Car<String>()
        car.fire()
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

open class Person {
    public final var name: String = ""
    public var sex: String = ""
    var point: Point = Point()
    lazy var speak = ["hello!"]
    lazy var lazyNunber = 100
    fileprivate var nameStr: String {
        name
    }
    var nameStr1: String {
        get {
            return name
        }
    }
    fileprivate var money: Int = 0 {
        willSet(newMoney) {
            print("person：newMoney:\(newMoney)");
        }
        didSet(oldMoney) {
            print("person：oldMoney:\(oldMoney) newMoney:\(money)")
        }
    }
    
    public func hair() {
        // do nothing
    }
    public final func grow() {
        print("成长")
    }
    
    static func classFunc1() {
        print("")
    }
    class func classFunc2() {
        print("")
    }
}

public class ManPerson: Person {
    var book: Book? 
    override var nameStr: String {
        get {
            return "man" + super.nameStr
        }
    }
    override var money: Int {
        willSet(newMoney) {
            print("man：newMoney:\(newMoney)");
        }
        didSet(oldMoney) {
            print("man：oldMoney:\(oldMoney) newMoney:\(money)")
        }
    }
    
    public override func hair() {
        super.hair()
        print("短头发")
    }
}

class Book: NSObject {
    var number: Int = 3
    func printNumber() {
        print("\(number)")
    }
}


class InitObject {
    let style: String
    var name: String
    var age: Int
    var sex: String = "男"
    internal var number: Int = 0
    required init () {
        self.style = "person"
        self.name = "tianmaotao"
        self.age = 0
    }
    init(_ name: String) {
        self.style = "person"
        self.name = name
        self.age = 0
    }
    init(_ age: Int) {
        self.style = "person"
        self.name = ""
        self.age = age
    }
    convenience init(sex: String) {
        self.init("person")
    }
    init?(with name: String?) {
        if name == nil {
            return nil
        }
        self.style = "person"
        self.name = ""
        self.age = 0
    }
    
    func printFunc() {
        let str = name + sex
        print("\(str)")
    }
}

class SubInitObject : InitObject {
    var isSub: Bool = true
    required init() {
        super.init()
    }
    override init(_ name: String) {
        super.init(name)
    }
    override convenience init(_ age: Int) {
        self.init("tianmaotao", age: age)
    }
    init(_ name: String, age: Int) {
        self.isSub = true
        super.init(name)
        self.age = age
    }
}


extension SubInitObject {
    var desc: String {
        get {
            "name:\(name) sex:\(sex) age:\(age)"
        }
    }
    func printDesc() {
        print("name:\(name) sex:\(sex) age:\(age)")
    }
}

extension SubInitObject {
    convenience init(name: String, sex: String, age: Int) {
        self.init(name)
    }
    func update(name: String, sex: String, age: Int) {
        self.name = name
        self.sex = sex
        self.age = age
    }
}

extension Point {
    init(with x: Float, with y: Float) {
        self.init(x: x, y: y)
    }
    func printDesc() {
        print("x:\(x) y:\(y)")
    }
}

protocol Animal {
    func printDesc()
}

protocol Cat {
    static var style: String {set get}
    var name: String {set get}
}

protocol CatProtocol: Cat {
    init(name: String)
    static func printStyle()
    func desc() -> String
    func descString(str: String)
}

class OrangeCat: CatProtocol {
    static var style: String = "OrangeCat"
    var name: String
    
    required init(name: String) {
        self.name = name
    }
    
    class func printStyle() {
        print("\(style)")
    }
    
    func desc() -> String {
        return "\(OrangeCat.style): \(name)"
    }
}

class Pet {
    var cat: CatProtocol
    var list: [CatProtocol]
    
    init(cat: CatProtocol) {
        self.cat = cat
        list = Array()
    }
    
    func getCat() -> CatProtocol {
        return  cat
    }
    func desc() {
        print("\(cat.desc())")
    }
    func printDesc(target: Animal & Cat) {
        target.printDesc()
        print("\(target.name)")
    }
    
    func updateCat(cat: CatProtocol) {
        if cat is CatProtocol {
            self.cat = cat
        }
        
        let objects: [AnyObject] = [
            OrangeCat(name: "xiaoming"),
            OrangeCat(name: "xiaohua"),
        ]
        for objc in objects {
            if let objectWithArea = objc as? CatProtocol {
                print("\(objectWithArea.name)")
            }
        }
    }

}

extension CatProtocol {
    func descString(str: String) {
        print("\(str)")
    }
}


///// 泛型
class Car<Element> {
    var items: [Element]?
    
    func fire() {
        var a = 19
        var b = 1
        swapTwoValuse(&a, &b)
    }
    
    func swapTwoValuse<T: Hashable>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }
    
    func push(_ item: Element) {
        if items == nil {
            items = Array()
        }
        items?.append(item)
    }
    
    func pop() {
        items?.removeLast()
    }
}

extension Car where Element: Hashable {
    
}


protocol Container {
    associatedtype ItemType: Hashable
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType{ get };
}

struct QSStack: Container {
    var list: [Int]
    init() {
        list = Array()
    }
    
    mutating func push(_ item: Int) {
        list.append(item)
    }
    mutating func pop() {
        list.removeLast()
    }
    
    /// 泛型Where分句
    ///泛型 Where 分句让你能够要求一个关联类型必须遵循指定的协议，或者指定的类型形式参数和关联类型必须相同。泛型 Where 分句以 Where 关键字开头，后接关联类型的约束或类型和关联类型一致的关系。
    static func allItemsMatch<C1: Container, C2: Container>(_ someContainer:C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1: Hashable  {
        if someContainer.count != anotherContainer.count {
            return false
        }
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        return true
    }
    
    ///protocol Container
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        push(item)
    }
    var count: Int {
        list.count
    }
    subscript(i: Int) -> Int {
        return list[i]
    }
}
