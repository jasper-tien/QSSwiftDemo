//
//  QSBaseTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/4/3.
//

import UIKit

typealias QSName = String

class QSBaseTest: NSObject {
    
    public func test_fire() {
        test_base()
        test_string()
        test_array();
        test_set();
        test_dictionary();
        test_contol();
        test_break();
        var a: Int = 1
        var b: Int = 2
        test_swap(&a, &b)
        
        let dic: [String:String] = ["name":"tianmaotao", "sex":"男"]
        test_guard(person: dic)
    }
    
    func test_base() {
        let httpMessage = (404, "not found")
        let httpMessage1 = (statusCode: 404, statusMessage: "not found")
        // 元组内容分解
        // 1、分解成单独的变量或者常量
        let (code, _) = httpMessage
        // 2、通过下标索引访问
        print("code:\(httpMessage.0) message:\(httpMessage.1)")
        // 3、通过元素的名字访问
        print("code:\(httpMessage1.statusCode) message:\(httpMessage1.statusMessage)")
        
        var v1, v2, v3 : Int
        var double : Double?
        var var1: String? = String()
        var var3: String = ""
        var var4: String = var1 ?? var3
        var name: QSName
        
        // If 语句以及强制展开
        if var1 != nil {
            print("print \(var1!)")
        }
        
        // 可选项绑定
        // 判断可选项是否包含值，如果包含就把值赋给一个临时的常量或者变量
        if let let1 = Int("3"), var var8 = Int("30"), let1 < var8 && let1 < 100 {
            
        }
        
        // 隐式展开可选项
        //通过在声明的类型后边添加一个叹号，可以去掉检查的需求，也不必每次访问的时候都进行展开。
        var var2: String! = "tianmaotao"
        var var5 = var2
        
        // 错误处理
        func canThrowAnError() throws {
            // do nothing
        }
        do {
            try canThrowAnError()
        } catch {
            
        }
        
        // 合并空值运算符
        // 合并空值运算符 （ a ?? b ）如果可选项 a  有值则展开，如果没有值，是 nil  ，则返回默认值 b 。表达式 a 必须是一个可选类型。表达式 b  必须与 a  的储存类型相同
        var double1 = 10.0
        var double2  = double ?? double1 // 等于 double != nil ? double! : double1
        
        // 闭区间运算符
        // 闭区间运算符（ a...b ）定义了从 a  到 b  的一组范围
        for index in 0...10 {
            print("闭区间运算符:\(index)")
        }
        
        // 半开区间运算符
        // 半开区间运算符（ a..<b ）定义了从 a  到 b  但不包括 b  的区间，即 半开 ，因为它只包含起始值但并不包含结束值。
        for index in 1..<10 {
            print("半开区间运算符:\(index)")
        }
        
        // 单侧区间
        // 闭区间有另外一种形式来让区间朝一个方向尽可能的远——比如说，一个包含数组所有元素的区间，从索引 2 到数组的结束。在这种情况下，你可以省略区间运算符一侧的值。
        var names: [String] = ["t", "m", "t"]
        for name in names[1...] {
            print("单侧区间:\(name)") // m, t
        }
        for name in names[...1] {
            print("单侧区间:\(name)") // t, m
        }
        for name in names[..<2] {
            print("单侧区间:\(name)") // t, m
        }
    }
    
    func test_string() {
        var str0 = String()
        let str = """
            jdlsfajl
            """
        let quotation = """
                The White Rabbit put on his spectacles.  "Where shall I begin,
                please your Majesty?" he asked.
                
                "Begin at the beginning," the King said gravely, "and go on
                till you come to the end; then stop."
                """
        let str1 = "tianmaotao"
        let str2: String
        str2 = str1
        if str.isEmpty {
            
        }
        let str3: String = "tianmao"
        for c in str3 {
            print("打印字符 \(c)")
        }
        
        let string1 = "tian"
        let string2 = "maotao"
        let string3 = "xing:\(string1) ming:\(string2)"
        let string4 = string1 + string2
        
        let chars: [Character] = ["我", "是" ,"1", "只" ,"🐱"]
        let str4: String = String(chars)
        var str5: String = str + str1
        let cStr: Character = "1"
        str5.append(cStr)
        var str6: String = String()
        str6.append("tianmaotao")
        str6.append("1")
        
        // 访问
        let index0Char = str3[str3.startIndex] // t
        let index1Char = str3[str3.index(after: str3.startIndex)] // i
        let index6Char = str3[str3.index(before: str3.endIndex)] // o
        let index3Char = str3[str3.index(str.startIndex, offsetBy: 2)] // a
        for index in str3.indices {
            print("\(str3[index])")
        }
        
        //  插入
        var str7 = "word"
        str7.insert("h", at: str.startIndex)
        str7.insert(contentsOf: "ello ", at: str7.index(after: str7.startIndex ))
        
        // 删除
        str7.remove(at: str7.startIndex)
        let rang = str7.startIndex..<str7.index(after: str7.startIndex)
        str7.removeSubrange(rang)
        
        let indexEnd = str7.firstIndex(of: " ") ?? str7.endIndex
        //可以使用同样的方式去操作 SubString 和 String。然而，跟 String 不同的是，你只有在短时间内需要操作字符串时，才会使用 SubString。当你需要长时间保存结果时，就把 SubString 转化为 String 的实例
        let subStr = str7[..<indexEnd] // hello, 得到一个 SubString 的实例
        let subStr1 = String(subStr)
        let numbers = [1, 3, 4, 5]
    }

    func test_array() {
        var array: [String] = [String]() // 简写
        var array1: Array<String> = Array<String>(); // 全称
        var array2 = [String]();
        array2.append("string")
        array2 = []
        var array3 = Array(repeating: 2, count: 2)
        var array4 = Array(repeating: 1, count: 2)
        // 合并数组
        var array5 = array3 + array4
        
        
        var array6: [String] = ["t", "m", "t"]
        var array7 = ["t", "m", "t"]
        array7 += ["h"]
        array7.append("a")
        
        array7[0] = "tian"
        array7[1...2] = ["maotao"]
        array7.insert("ha", at: 2)
        array7.remove(at: 2)
        
        for str in array7 {
            print("\(str)")
        }
        for (index, value) in array7.enumerated() {
            print("\(index) \(value)")
        }
        
        var names: [String] = [String]()
        for index in 0..<names.count {
            print("我的名字叫 \(names[index]) ")
        }
        for name in names[0...] {
            print("我的名字叫 \(name) ")
        }
    }
    
    func test_set() {
        var set1 = Set<String>()
        set1 = []
        var set2: Set<String> = ["tianmaotao", "tianmaohai"]
        var set3: Set = ["tianmaotao"]
        if !set3.isEmpty {
            if set3.contains("tianmaotao") {
//                set3.remove("tianmaotao")
            }
            set3.insert("tianrujin")
        }
        
        for str in set3 {
//            print("\(str)")
        }
        for str in set3.sorted() {
//            print("\(str)")
        }
        
        // 返回一个合集，只包含set2合集值，不包含set3合集值的新合集。
        var set4 = set2.subtracting(set3)
        
        // 返回一个合集，只包含set2和set3两个共享元素
        var set5 = set2.intersection(set3)
        
        //返回一个合集，只包含set2和set3非共享元素
        var set6 = set2.symmetricDifference(set3)
        
        // 返回一个合集，包含set2和set3所有值
        var set7 = set2.union(set3)
        
        
        // 使用“相等”运算符 ( == )来判断两个合集是否包含有相同的值；
        // 使用 isSubset(of:) 方法来确定一个合集的所有值是被某合集包含；
        // 使用 isSuperset(of:)方法来确定一个合集是否包含某个合集的所有值；
        // 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:)方法来确定是个合集是否为某一个合集的子集或者超集，但并不相等；
        // 使用 isDisjoint(with:)方法来判断两个合集是否拥有完全不同的值。
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
         
        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
    }
    
    func test_dictionary() {
        var dic = [Int:String]() // 简写
        var dic1: Dictionary<Int,String> = Dictionary<Int,String>() // 全称
        dic = [:]
        var dic2 = [1:"1", 2:"2", 3:"3"]
        
        if let oleValue = dic2.updateValue("4", forKey: 4) {
//            dic2[1] = nil
            if let value1 = dic2.removeValue(forKey: 1) {
                
            }
        }
        dic[1] = "tian"
        dic[2] = nil
        
        for (key, value) in dic2 {
            
        }
    }
    
    func test_contol() {
        let dic = [1:"1", 2:"2", 3:"3"]
        for (key, value) in dic {
//            print("第\(key)个value为\(value)")
        }
        
        for index in 1...5 {
//            print("第\(index)个")
        }
        
        var count: Int = 0
        for _ in 1..<5 {
            count += 1
        }
        
        for num in stride(from: 0, through: 60, by: 5) {
//            print("\(num)");
        }
        
        var count1 = 5
        while count1 > 0 {
//            print("\(count1)")
            count1 -= 1
        }
        repeat {
//            print("\(count1)")
            count1 += 1
        } while count1 < 5
        
        let c1: Character = "a"
        switch c1 {
        case "a", "b" :
            print("print a b")
        case "c" :
            print("print c")
        default :
            print("default")
        }
        
        // 区间匹配
        let num = 89
        switch num {
        case 0..<10 :
            print("\(num)属于0...9区间")
        case 10..<100 :
            print("\(num)属于10...99区间")
        case 100..<1000 :
            print("\(num)属于100...999区间")
        default:
            print("none")
        }
        
        // 元组
        // 使用下划线（ _）来表明匹配所有可能的值
        let point = (2, 2)
        switch point {
        case (0, 0) :
            print("(0, 0)")
        case (_, 2) :
            print("(x, 2)")
        case (3, _) :
            print("(3, x)")
        case (-1...1, -2...2) :
            print("(-1...1, -2...2)")
        default:
            print("none")
        }
        
        // 值绑定
        // 将匹配到的值临时绑定为一个常量或者变量，来给情况的函数体使用
        switch point {
        case (let x, 1):
            print("(\(x), 1)")
        case (2, let y):
            print("(2, \(y))")
        default:
            print("none")
        }
        
        // Where
        switch point {
        case let(x, y) where x == y:
            print("x==y")
        case let(x, y):
            print("")
        default:
            print("")
        }
    }
    
    func test_break() {
        let str = "great minds think alike"
        let chars: [Character] = ["a", "e", "i", "o", "u", " "]
        var chars1 = ""
        for char in str {
            if chars.contains(char) {
                continue
            } else {
                chars1.append(char)
            }
        }
        
        let a = "n"
        switch a {
        case "a":
            print("a")
        case "n":
            print("n")
            fallthrough
        case "o":
            print("o")
        default:
            break
        }
        
        
        var count = 4
        loopTest: while count > 0 {
            count -= 1
            print("start \(count)")
            conditionTest : switch count {
            case 1:
                break loopTest
                fallthrough
            case 2:
                break conditionTest
                fallthrough
            default:
                print("default")
            }
            print("end")
        }
    }
    
    func test_guard(person: [String:String]) {
        guard let name = person["name"] else {
            return
        }
        guard let sex = person["sex"] else {
            return
        }
        print("name:\(name) sex:\(sex)")
    }
    
    func test_func(for person: String) -> String {
        "tianmaotao"
    }
    func test_func1(_ numbers: Int...) -> Int {
        var sum: Int = 0
        if !numbers.isEmpty {
            for num in numbers {
                sum += num
            }
        }
        return sum
    }
    
    func test_swap(_ a: inout Int, _ b: inout Int) {
        let c = a;
        a = b
        b = c
    }
    
    func test_函数类型作为参数(_ a: Int , b: Int, funcName: (Int, Int) -> Int) -> Int {
        return funcName(a, b)
    }
    func test_sum(a: Int, b: Int) -> Int {
        return a + b
    }
    func test_函数类型作为返回值(a: Int, b:Int) -> (Int, Int) ->Int {
        return test_sum
    }
    
    func test_内嵌(a: Int, b: Int, isSum: Bool) -> Int {
        func _test_sum(a: Int, b: Int) -> Int {
            return a + b
        }
        func _test_multiply(a: Int, b: Int) -> Int {
            return a * b
        }
        if isSum {
            return _test_sum(a: a, b: b)
        } else {
            return _test_multiply(a: a, b: b)
        }
    }
}
