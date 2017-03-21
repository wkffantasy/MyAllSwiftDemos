//
//  DialController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/20.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DialController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.colorWithRGB(red: 76, green: 130, blue: 255)

        setupDialView()
    }

    func setupDialView() {
        let titleArray = [
            "东风破",
            "发如雪",
            "青花瓷",
            "兰亭序",
            "千里之外",
            "红尘客栈",
            "琴殇",
            "七里香",
        ]
        let dial = DialView.init(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenWidth), titleArray: titleArray)
        self.view.addSubview(dial)
    }
}
