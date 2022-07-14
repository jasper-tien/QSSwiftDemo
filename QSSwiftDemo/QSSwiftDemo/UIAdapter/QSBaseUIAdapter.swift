//
//  QSBaseUIAdapter.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/4/17.
//

import UIKit

class QSBaseUIAdapter<Adapter: AnyObject> {
    var parentUIAdapter: Adapter?
    let childUIAdapters: [QSBaseUIAdapter]
    
    init() {
        childUIAdapters = Array()
    }
}
