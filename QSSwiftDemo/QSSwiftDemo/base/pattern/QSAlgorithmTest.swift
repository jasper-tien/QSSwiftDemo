//
//  QSAlgorithmTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/12/22.
//

import Foundation

/// 二分查找

class QSAlgorithmTest {
    
    func fireFunc() {
        let nums = [2, 5, 7, 9, 23, 50, 69]
        let targetNum = 8
        let index = binarySearch(nums, targetNum: targetNum)
        print("\(index)")
    }
    
    private func binarySearch(_ nums: [Int], targetNum: Int) -> Int? {
        if nums.count == 0 {
            return nil
        }
        var mid: Int = 0
        var left: Int = 0
        var right: Int = nums.count - 1
        while left <= right {
            mid = (left + right) / 2
            let midNum = nums[mid]
            if targetNum == midNum {
                return mid
            } else if targetNum > midNum {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}
