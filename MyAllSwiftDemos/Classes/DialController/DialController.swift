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
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.colorWithRGB(red: 76, green: 130, blue: 255)

//        setupDialView()
        setupSliderCircleView()
    }
    func setupSliderCircleView() {
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
        let imageNameArray = [
            "test_0",
            "test_1",
            "test_2",
            "test_3",
            "test_4",
            "test_5",
            "test_6",
            "test_7",
//            "test_8",
        ]
        assert(imageNameArray.count == titleArray.count,"")
        let slider = SliderCircleView.init(frame: CGRect(x:0,y:64,width:ScreenWidth,height:ScreenWidth), titleArray: titleArray, imageNameArray: imageNameArray)
        self.view.addSubview(slider)
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

        let line1 = UIView()
        line1.backgroundColor = UIColor.blue
        dial.addSubview(line1)
        line1.snp.makeConstraints { make in
            make.center.equalTo(dial.snp.center)
            make.width.equalTo(1)
            make.top.bottom.equalTo(0)
        }

        let line2 = UIView()
        line2.backgroundColor = UIColor.blue
        dial.addSubview(line2)
        line2.snp.makeConstraints { make in
            make.center.equalTo(dial.snp.center)
            make.height.equalTo(1)
            make.left.right.equalTo(0)
        }
    }
}
