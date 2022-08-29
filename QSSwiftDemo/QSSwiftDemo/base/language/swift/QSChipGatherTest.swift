//
//  QSChipGatherTest.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/21.
//

import Foundation

class QSChipGatherTest: QSTestProtocol {
    func test_fire() {
        chipTest(key: QSChip.Key.bgColorStr)
    }
    
    func chipTest(key: QSChip.Key) {
        print("\(key)")
    }
}

/// 嵌套类型
class QSChip {
    struct Key {
        private var name: String
        var keyName: String {
            return name
        }
        init(name: String) {
            self.name = name
        }
    }
}
extension QSChip.Key {
    static let bgColorStr: QSChip.Key = QSChip.Key(name: "Orange")
    static let widthStr: QSChip.Key = QSChip.Key(name: "100")
}


/// 访问控制
// 五种不同的访问级别:
// 1、Open 和 Public
// 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。
// 通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。Open 和 Public 的区别在后面会提到。
// 2、Internal
// 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。
// 通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
// 3、File-private
// 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
// 4、Private
// 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。
// 如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。

//open 访问仅适用于类和类成员，它与 public 访问区别如下：
// public 访问，或任何更严格的访问级别的类，只能在其定义模块中被继承。
// public 访问，或任何更严格访问级别的类成员，只能被其定义模块的子类重写。
// open 类可以在其定义模块中被继承，也可在任何导入定义模块的其他模块中被继承。
// open 类成员可以被其定义模块的子类重写，也可以被导入其定义模块的任何模块重写。

// 显式地标记类为 open 意味着你考虑过其他模块使用该类作为父类对代码的影响，并且相应地设计了类的代码。


/// 访问级别的指导准则：
// Swift 中的访问级别遵循一个基本原则：实体不能定义在具有更低访问级别（更严格）的实体中。
// 例如：
// 一个 public 的变量其类型的访问级别不能是 internal, file-private 或是 private，因为在使用 public 变量的地方可能没有这些类型的访问权限。
// 一个函数不能比它的参数类型和返回类型访问级别高，因为函数可以使用的环境而其参数和返回类型却不能使用。

