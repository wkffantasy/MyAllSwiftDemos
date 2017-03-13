//
//  MarqueeController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class MarqueeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        // init only text
        let titleView1 = MarqueeView.init(frame: CGRect(x: 50, y: 70, width: ScreenWidth - 100, height: 40), text: "缓缓飘落的枫叶像思念，我点燃烛火温暖岁末的秋天")
        self.view.addSubview(titleView1)

        // init with text and font
        let titleView2 = MarqueeView.init(frame: CGRect(x: 50, y: 120, width: ScreenWidth - 100, height: 40), text: "你说把爱渐渐放下回忆走更远", font: UIFont.systemFont(ofSize: 11))
        self.view.addSubview(titleView2)

        // init with text, font and color
        let titleView3 = MarqueeView.init(frame: CGRect(x: 50, y: 180, width: ScreenWidth - 100, height: 40), text: "最美的不是下雨天，是曾与你躲过雨的屋檐", font: UIFont.systemFont(ofSize: 22), color: UIColor.red)
        self.view.addSubview(titleView3)

        // init with text and color
        let titleView4 = MarqueeView.init(frame: CGRect(x: 50, y: 240, width: ScreenWidth - 100, height: 40), text: "海天连线的地方是那夕阳，木造的甲板一整遍是那金黄", color: UIColor.blue)
        self.view.addSubview(titleView4)

        // update it after a delay
        let titleView5 = MarqueeView.init(frame: CGRect(x: 50, y: 300, width: ScreenWidth - 100, height: 40), text: "你背光的轮廓就像剪影一样，充满了想象，任谁都会爱上", color: UIColor.blue)
        self.view.addSubview(titleView5)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {

            titleView5.updateContent(text: "孩子听妈妈的话", font: UIFont.systemFont(ofSize: 26), color: UIColor.red)
        }

        // update it after a delay
        let titleView6 = MarqueeView.init(frame: CGRect(x: 50, y: 360, width: ScreenWidth - 100, height: 40), text: "你笑一点一点一滴荡开", color: UIColor.blue)
        self.view.addSubview(titleView6)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0) {

            titleView6.updateContent(text: "为你弹奏肖邦的夜曲，纪念我逝去的爱情，而我为你隐姓埋名在月光下弹琴", font: UIFont.systemFont(ofSize: 14), color: UIColor.green)
        }
    }
}
