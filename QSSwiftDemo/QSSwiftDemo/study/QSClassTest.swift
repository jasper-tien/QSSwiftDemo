//
//  QSClassTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/10.
//

import Foundation

public protocol QSTestProtocol {
    func test_fire() -> Void
}

class QSClassTest: QSTestProtocol {
    public func test_fire() {
        let man: ManPerson = ManPerson()
        man.book?.number = 10
        man.money = 10
        if (man.book?.number = 100) != nil {
            
        }
        if let books = man.book?.number {
            let booksCount = books + 10
        }
        if man.book?.printNumber() != nil {
            
        }
        
        let media = QSMediaTest()
        media.test_print()
    }
}

open class Person {
    public final var name: String = ""
    public var sex: String = ""
    var point: Point = Point()
    lazy var speak = ["hello!"]
    lazy var lazyNunber = 100
    var nameStr: String {
        name
    }
    var nameStr1: String {
        get {
            return name
        }
    }
    
    // 属性观察者
    // 你可以在如下地方添加属性观察者：
    // 1、你定义的存储属性；
    // 2、你继承的存储属性；
    // 3、你继承的计算属性；
    var money: Int = 0 {
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


// 初始化器
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


// 类型转换
// 类型检查：使用类型检查操作符 （ is ）来检查一个实例是否属于一个特定的子类。如果实例是该子类类型，类型检查操作符返回 true ，否则返回 false 。
// 向下类型转换：使用条件形式的类型转换操作符 （ as? ）。返回一个可选项，如果向下转换失败，可选值为 nil
// 使用强制形式的类型转换操作符（ as! ）。当你向下转换至一个错误的类型时，强制形式的类型转换操作符会触发一个运行错误。
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

class QSMediaTest {
    var list: [Any] = [
        Movie(name: "Movie1", director: "tmt"),
        Movie(name: "Movie2", director: "tmt"),
        Song(name: "Song1", artist: "tmt"),
        Song(name: "Song2", artist: "tmt"),
        10,
        (100, 100)
    ]
    
    func test_print() {
        var movieCount = 0
        var songCount = 0
        for item in list {
            if item is Movie {
                movieCount += 1
            }
            if item is Song {
                songCount += 1
            }
        }
        print("movie count:\(movieCount) song count:\(songCount)")
        
        for item in list {
            if let movie = item as? Movie {
                print("movie name:\(movie.name)")
            }
            if let song = item as? Song {
                print("song:\(song.name)")
            }
        }
        
        for item in list {
            switch item {
            case let movie as Movie:
                print("movie name:\(movie.name)")
            case let song as Song:
                print("song:\(song.name)")
            case let intNum as Int where intNum == 10:
                print("\(intNum)")
            case let (x, y) as (Int, Int) where x > 0 && y > 0:
                print("x:\(x), y:\(y)")
            default:
                print("default")
            }
        }
    }
}
