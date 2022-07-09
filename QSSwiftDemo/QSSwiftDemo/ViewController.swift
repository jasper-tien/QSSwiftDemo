//
//  ViewController.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/3/27.
//

import UIKit

//swift测试 demo
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func funcString(_ str: String) {
        print("desc:\(str)")
    }
    
    func funInt(_ num: Int) {
        print("desc:\(num)")
    }
    
    func funcFloaf(_ num: Float) {
        print("\(num)")
    }
    
    func funcDouble(_ num: Double) {
        print("desc:\(num)")
    }
}

