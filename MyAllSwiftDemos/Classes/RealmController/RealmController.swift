//
//  RealmController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/22.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import Realm

class Dog: NSObject {
    dynamic var name = ""
    dynamic var age  = 0
}
class Person: NSObject {
    dynamic var name = ""
    dynamic var age = 0
    
    
}

class RealmController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myDog = Dog()
        myDog.name = "aaa"
        myDog.age = 1
//        let realm = try! Realm
//        
//        let puppies = realm.objects(Dog.self).filter("age<2")
//        
//        print()
    }


}
