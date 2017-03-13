//
//  Constants.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/7.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import SnapKit

// all notification names

// constants

let curveMaxHeight: CGFloat = 60

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let functionsArray = [
    [
        "title": "Label的跑马灯",
        "titleDescription": "当文字超过一定的长度的时候，该文字会一直轮播下去，也就是跑马灯的效果",
        "status": "完成",
        "jumpTo": "jumpToMarqueeVC",
    ],
]

let funnyArray = [
    [
        "title": "可以滑动的弧形",
        "titleDescription": "根据tableview的滑动 弧形进行动画",
        "status": "待做",
        "jumpTo": "jumpToCurveVC",
    ],
]
