//
//  QSBlockTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/14.
//

import Foundation

class QSBlockTest: QSTestProtocol {
    func test_fire() {
        test_闭包()
    }
    
    func test_函数类型作为参数(_ a: Int , b: Int, funcName: (Int, Int) -> Int) -> Int {
        return funcName(a, b)
    }
    
    func test_sum(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func test_闭包() {
        // 闭包表达式语法
        // { (parameters) -> (return type) in
        //    statements
        // }
        let sum1 = test_函数类型作为参数(1, b: 3, funcName: {
            (a: Int, b: Int) -> Int in
            let sum = a + b
            return sum
        })
        // 从语境中推断类型(推断它的形式参数类型和返回类型)
        // 从单表达式闭包隐式返回
        let sum2 = test_函数类型作为参数(1, b: 3, funcName: { s1, s2 in
            s1 + s2
        })
        // 简写的实际参数名
        let sum3 = test_函数类型作为参数(1, b: 3) {
            $0 + $1
        }
        
        let sum_block = { (s1: Int, s2: Int) -> Int in
            return s1 + s2
        }
        let sum4 = test_函数类型作为参数(1, b: 3, funcName: sum_block)
        
        let sum5 = test_函数类型作为参数(1, b: 3, funcName: test_sum)
        
        // 尾随闭包
        let sum6 = test_函数类型作为参数(1, b: 3) { s1, s2 in
            s1 + s2
        }
    }
    func test_闭包简写() {
        let sum2 = test_函数类型作为参数(2, b: 3, funcName: {
            $0 + $1
        })
    }
    func test_尾随闭包_多参数(url: String, completion: (String) -> Void, failure: () -> Void) {
        var isSucess: Bool = false
        if isSucess {
            completion("sucess")
        } else {
            failure()
        }
    }
    func test_尾随闭包() {
        let sum = test_函数类型作为参数(2, b: 3) {
            $0 + $1
        }
        
        test_尾随闭包_多参数(url: "www.baidu.com") { (url: String) -> Void in
            print("\(url)")
        } failure: {
            print("failure")
        }
        
        let digitNames = [
             0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
             5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
          ]
        let list: [Int] = [16,58,510]
        let strings = list.map() {
            (num: Int) -> String in
            var number = num
            var outstr = ""
            repeat {
                outstr = digitNames[number % 10]! + outstr
                number /= 10
            }  while number > 0
            return outstr
        }
        
    }
    
    var handlers: [() -> Void] = []
    func test_闭包逃逸(completionHandler: @escaping () -> Void) {
        handlers.append(completionHandler)
    }
    func test_非闭包逃逸(completionHandler:() -> Void) {
        completionHandler()
    }
}
