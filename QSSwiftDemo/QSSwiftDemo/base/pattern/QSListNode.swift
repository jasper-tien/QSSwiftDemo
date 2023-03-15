//
//  QSListNode.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2023/3/15.
//

import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

extension ListNode {
    
    static func convertString(_ head: ListNode?) -> String {
        var p = head
        var ret = ""
        while p != nil {
            ret += "\(p!.val) "
            p = p?.next
        }
        return ret
    }
    
    static func printNodeList(_ head: ListNode?, _ identify: String = "") {
        var ret = self.convertString(head)
        if identify.count > 0 {
            print(identify + ": " + ret)
        } else  {
            print(ret)
        }
    }
}

class ListNodeTest {
    func fire() {
        
    }
}
