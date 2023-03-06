//
//  CreationalPattern.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/5/15.
//

import UIKit

/*
 简单工厂模式
 1、定义：
 又称为静态工厂方法模式，它属于类创建型模式。在简单工厂模式中，可以根据参数的不同返回不同类的实例。
 简单工厂模式专门定义一个类来负责创建其他类的实例,被创建的实例通常都具有共同的父类。
 
 2、使用场景：
 需要根据场景创建不同的对象。
 
 3、模式结构
 I. Factory：工厂角色
 工厂角色负责实现创建所有实例的内部逻辑。
 II. Product：抽象产品角色
 抽象产品角色是所创建的所有对象的父类，负责描述所有实例所共有的公共接口。
 III. ConcreteProduct：具体产品角色
 具体产品角色是创建目标，所有创建的对象都充当这个角色的某个具体类的实例。
 */

protocol Product1 {
    var name: String?{ get set }
    func fire()
}

class Product1_A: Product1 {
    var name: String?
    func fire() {
        
    }
}

class Product1_B: Product1 {
    var name: String?
    func fire() {
        
    }
}

class Factory1 {
    class func fetchProduct(with key: String) -> Product1? {
        if key == "a" {
            return Product1_A()
        } else if key == "b" {
            return Product1_B()
        }
        return nil
    }
}


/*
 工厂方法模式
 1、定义
 工厂方法模式又称为工厂模式，也叫虚拟构造器模式或者多态工厂模式，它属于类创建型模式。
 在工厂方法模式中，工厂父类负责定义创建产品对象的公共接口，而工厂子类则负责生成具体的产品对象，
 这样做的目的是将产品类的实例化操作延迟到工厂子类中完成，即通过工厂子类来确定究竟应该实例化哪一个具体产品类。
 
 2、使用场景
 客户只知道创建产品的工厂名，而不知道具体的产品名。如 TCL 电视工厂、海信电视工厂等。
 创建对象的任务由多个具体子工厂中的某一个完成，而抽象工厂只提供创建产品的接口。
 客户不关心创建产品的细节，只关心产品的品牌
 
 3、模式呢结构
 抽象工厂（Abstract Factory）：提供了创建产品的接口，调用者通过它访问具体工厂的工厂方法 newProduct() 来创建产品。
 具体工厂（ConcreteFactory）：主要是实现抽象工厂中的抽象方法，完成具体产品的生产过程。
 抽象产品（Product）：定义了产品的规范，描述了产品的主要特性和功能。
 具体产品（ConcreteProduct）：实现了抽象产品角色所定义的接口，由具体工厂来创建，它同具体工厂之间一一对应。
 
 */

protocol Product2 {
    func show()
}

protocol Factory2 {
    static func createProduct() -> Product2
}

class Product2_A: Product2 {
    func show() {
        print("A")
    }
    func config() {
        
    }
}

class Factory2_A: Factory2 {
    static func createProduct() -> Product2 {
        let product = Product2_A()
        product.config()
        return product
    }
}

class Product2_B: Product2 {
    func show() {
        print("B")
    }
    func config() {
        
    }
}

class Factory2_B: Factory2 {
    class func createProduct() -> Product2 {
        let product = Product2_B()
        product.config()
        return product
    }
}


/*
 抽象工厂模式
 1、定义
 
 2、使用场景
 使用抽象工厂模式一般要满足以下条件。
 - 系统中有多个产品族，每个具体工厂创建同一族但属于不同等级结构的产品。
 - 系统一次只可能消费其中某一族产品，即同族的产品一起使用。

 抽象工厂模式除了具有工厂方法模式的优点外，其他主要优点如下。
 - 可以在类的内部对产品族中相关联的多等级产品共同管理，而不必专门引入多个新的类来进行管理。
 - 当需要产品族时，抽象工厂可以保证客户端始终只使用同一个产品的产品组。
 - 抽象工厂增强了程序的可扩展性，当增加一个新的产品族时，不需要修改原代码，满足开闭原则。
 
 3、模式呢结构
 
 */



