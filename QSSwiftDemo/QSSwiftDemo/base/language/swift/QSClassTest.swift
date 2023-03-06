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
        
        let subscriptObj = SubscriptClass()
        if let value = subscriptObj[1] {
            print("\(value)")
        }
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
    // ps：也可以作用在全局变量上
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

// 下标语法
// 标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式。
class SubscriptClass {
    var numbers = ["t", "m", "t"]
    
    // 指定一个或多个输入参数和返回类型，如果是多参数使用时下标的入参使用逗号分隔；
    // 这种行为由 getter 和 setter 实现，有点类似计算型属性
    subscript(index: Int) -> String? {
        set {
            if index < numbers.count {
                numbers[index] = newValue ?? ""
            }
        }
        get {
            if index < numbers.count {
                return numbers[index]
            }
            return nil
        }
    }
    
    // 如同只读计算型属性，可以省略只读下标的 get 关键字
//    subscript(index: Int) -> Int {
//
//    }
}
