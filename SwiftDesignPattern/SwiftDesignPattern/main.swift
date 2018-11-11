//
//  main.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/26.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import Foundation

func protypeTest(){
    let a = TestClassSub()
    let b = a.copy()
    b.data = 1
    print(b.data)
    print(a.data)
    var c = TestStruct()
    var d = c
    //用于打印结构内存地址的函数
    withUnsafePointer(to: &c) {print($0)}
    withUnsafePointer(to: &d) {print($0)}
    print(c,d)
}


func factoryTest(){
    let p = ConcreteFactory.creatFor(subclass: ConcreteProduct.self)
    p?.use()
}


func absFactoryTest(){
    if let listFactory = AbstractFactory.creatFactory(subclass: ListFactory.self) {
        
        let people = listFactory.createLink(caption: "人民日报", url: "http://www.people.com.cn/");
        let gmw = listFactory.createLink(caption: "光明日报", url: "http://www.gmw.cn/");
        let us_yahoo = listFactory.createLink(caption: "Yahoo!", url: "http://www.yahoo.com/");
        let jp_yahoo = listFactory.createLink(caption: "Yahoo!Japan", url: "http://www.yahoo.co.jp/");
        let excite = listFactory.createLink(caption: "Excite", url: "http://www.excite.com/");
        let google = listFactory.createLink(caption: "Google", url: "http://www.google.com/");
        
        
        let traynews = listFactory.createTray(caption: "日报");
        traynews.add(people)
        traynews.add(people);
        traynews.add(gmw);
        
        let trayyahoo = listFactory.createTray(caption: "Yahoo!");
        trayyahoo.add(us_yahoo);
        trayyahoo.add(jp_yahoo);
        
        let traysearch = listFactory.createTray(caption: "检索引擎");
        traysearch.add(trayyahoo);
        traysearch.add(excite);
        traysearch.add(google);
        
        let page = listFactory.createPage(title: "LinkPage", author: "杨文轩");
        page.add(traynews);
        page.add(traysearch);
        page.output();
        
    }
}

func builderTest(){
    let p = Director(BlackBuilder()).construct()
    p.show()
}

func singletonTest(){
    let a = SingletonObject.sharedInstance
    var s = 0
    for i in 0..<100 {
        DispatchQueue.global().async {
            a.data += 1
            a.data -= 1
            DispatchQueue.main.sync {
                print(a.data)
            }
        }
        DispatchQueue.global().async {
            DispatchQueue.main.sync {
                print(a.data)
            }
        }
        if i % 2 == 0 {
            DispatchQueue(label: "test").async {
                a.data += 1
                s += 1
                DispatchQueue.main.sync {
                    print(">>>>>>\(a.data) \(s)<<<<<<<")
                }
            }
        }
    }
}


func adapterTest(){
    let a = Adapter(adaptee: Adaptee())
    a.request()
}



func runloopTest(){
    // 命令行模式下，需要启动一个runloop才可以保护多线程
    let runLoop = CFRunLoopGetCurrent();
    let runLoopMode = CFRunLoopMode.defaultMode;
    let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                      CFRunLoopActivity.allActivities.rawValue,
                                                      false, 0) { (server, act) in
                                                        singletonTest()
    }
    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
    CFRunLoopRun()
}

func iteratorTest() {
    let t = ItemSet()
    t.appendItem(i: Item("Alpha"))
    t.appendItem(i: Item("Beta"))
    t.appendItem(i: Item("Mu"))
    t.appendItem(i: Item("Nu"))
    
    let i = t.iterator
    while i.hasNext() {
        let t = i.next() as! Item
        print(t.getName())
    }
    
}


func templateMethodTest() {
    let t = CharDisplay("H")
    t.display()
}



