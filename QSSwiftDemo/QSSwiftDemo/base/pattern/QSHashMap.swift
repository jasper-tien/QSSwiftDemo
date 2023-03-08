//
//  QSHashMap.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2023/3/8.
//

import Foundation

private class HashMapEntry {
    var key: String
    var value: Any
    init(key: String, value: Any) {
        self.key = key
        self.value = value
    }
}

let defaultSize = 20

open class HashMap {
    private var _size: Int = 0
    private var currentSize: Int = 0
    let loadFactorMax: Float = 0.7
    
    private var list: [HashMapEntry?]
    
    public var size: Int {
        get {
            _size
        }
    }
    public var validSize: Int {
        get {
            _size - currentSize
        }
    }
    public var allKeys: [String] {
        var keys = [String]()
        for objc in list {
            if let entry = objc {
                keys.append(entry.key)
            }
        }
        return keys
    }
    
    init(size: Int) {
        list = Array(repeating: nil, count: size)
        _size = size
    }
    
    // MARK: public methods
    
    public func add(key: String, value: Any) {
        // 通过哈希算法，得到index索引
        var index = hashCode(key)
        
        // 如果哈希冲突，使用开放地址法---线性地址探测法解决
        while list[index] != nil {
            if list[index]?.key == key {
                list[index] = generateEntry(key: key, value: value)
                return
            }
            index = (index + 1) & _size
        }
        
        list[index] = generateEntry(key: key, value: value)
        currentSize += 1
        
        if _size > 0 {
            // 检查装载因子，如果超过阈值则进行扩容
            let loadFactor = Float(currentSize) / Float(_size)
            if loadFactor > loadFactorMax {
                resize()
            }
        }
    }
    
    public func fetch(_ key: String) -> Any? {
        // 通过哈希算法，得到index索引
        var index = hashCode(key)
        while list[index] != nil {
            if list[index]?.key == key {
                return list[index]?.value
            }
            index = (index + 1) & _size
        }
        
        return nil
    }
    
    public func remove(_ key: String) {
        // 通过哈希算法，得到index索引
        var index = hashCode(key)
        while list[index] != nil {
            if list[index]?.key == key {
                list[index] = nil
                currentSize -= 1
                return
            }
            index = (index + 1) & _size
        }
    }
    
    public func clear() {
        list.removeAll()
        _size = 0
        currentSize = 0
    }
    
    // MARK: private methods
    
    // 扩容
    private func resize() {
        let oldList = list
        let oldSize = _size
        _size = _size * 2
        
        list = Array(repeating: nil, count: _size)
        
        for index in 0..<oldSize {
            if let entry = oldList[index] {
                add(key: entry.key, value: entry.value)
            }
        }
    }
    
    // 获取key的哈希值
    private func hashCode(_ key: String) -> Int {
        var hash: Int = 0
        for char in key {
            hash = 31 &* hash + Int(char.asciiValue!)
        }
        return hash % _size
    }
    
    private func generateEntry(key: String, value: Any) -> HashMapEntry {
        return HashMapEntry(key: key, value: value)
    }
}

class HashTest {
    func fire() {
        let hashMap = HashMap(size: 20)
        hashMap.add(key: "key1", value: "dog")
        hashMap.add(key: "key2", value: "cat")
        
        for key in hashMap.allKeys {
            print("key:\(key) value:\(hashMap.fetch(key) ?? "")")
        }
    }
}
