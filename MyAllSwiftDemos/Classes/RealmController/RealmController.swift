//
//  RealmController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/22.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

//import Realm
//
//class Dog: NSObject {
//    dynamic var name = ""
//    dynamic var age  = 0
//}
//class Person: NSObject {
//    dynamic var name = ""
//    dynamic var age = 0
//    
//    
//}

class RealmController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let view = AnimateView()
        view.frame = UIScreen.main.bounds
        self.view.addSubview(view)
    }


}
