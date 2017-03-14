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
    [
        "title": "tabsSelectView",
        "titleDescription": "很经典的一个样式，写的多了，比较麻烦，封装了一个这样的view，可以是文字，可以是图片。但具体的里面的颜色需要自己定制",
        "status": "完成",
        "jumpTo": "jumpToTabSelectVC",
    ],
    [
        "title": "scroll item的无缝无限循环滚动",
        "titleDescription": "一个scrollView 里面有好多图片 或者item，可以一直左滑 也可以一直右滑，使用frame做的，目前没有用到SnapKit",
        "status": "完成",
        "jumpTo": "jumpToNoMarginScrollVC",
    ],
    [
        "title": "自己写的视频播放器",
        "titleDescription": "挑战一下自己",
        "status": "正在做",
        "jumpTo": "jumpToVideoVC",
        ],
]

let funnyArray = [
    [
        "title": "可以滑动的弧形",
        "titleDescription": "根据tableview的滑动 弧形进行动画",
        "status": "完成",
        "jumpTo": "jumpToCurveVC",
    ],
]

//video
//let void kBackViewIdentifier = &kBackViewIdentifier;
