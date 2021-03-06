//
//  DialController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/20.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DialController: UIViewController {
    private var tipLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.colorWithRGB(red: 76, green: 130, blue: 255)
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
            //            "琴殇",
            //            "七里香",
        ]
        let imageNameArray = [
            "test_0",
            "test_1",
            "test_2",
            "test_3",
            "test_4",
            "test_5",
            //            "test_6",
            //            "test_7",
            //            "test_8",
        ]
        assert(imageNameArray.count == titleArray.count, "")
        let slider = SliderCircleView.init(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenWidth), titleArray: titleArray, imageNameArray: imageNameArray)
        slider.clickItemTag = { [weak self] tag in
            self?.tipLabel.text = String(format: "点击了第%d个item", tag)
        }
        self.view.addSubview(slider)

        tipLabel = UILabel()
        tipLabel.text = "你还没点item"
        tipLabel.textColor = UIColor.white
        view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
