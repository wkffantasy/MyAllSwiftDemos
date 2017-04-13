//
//  TabBarController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/31.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var customTabBar: CustomTabBar!

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
            "titleDescription": "挑战一下自己,目前正常的功能已经完成。可以快进，快退，全屏，小屏。",
            "status": "待完善吧",
            "jumpTo": "jumpToVideoVC",
        ],
        [
            "title": "一个转盘",
            "titleDescription": "自己写一个可以手动转的转盘，转盘至少要有n>1的item。转动的时候item和分割线一起转动。a.有一个体验不好的地方就是在y轴上pan的手势滑动效果不明显。b.item只能是垂直向下",
            "status": "待完善吧",
            "jumpTo": "jumpToNoDialVC",
        ],
        [
            "title": "上拉下拉刷新",
            "titleDescription": "在写",
            "status": "待完善吧",
            "jumpTo": "jumpToRefreshVC",
        ],
    ]

    let funnyArray = [
        [
            "title": "可以滑动的弧形",
            "titleDescription": "根据tableview的滑动 弧形进行动画",
            "status": "完成",
            "jumpTo": "jumpToCurveVC",
        ],
        [
            "title": "一个waveView",
            "titleDescription": "网上看到好多这个wave的。找了一个 自己用swift写了一下，只有写一点，才能学一点。",
            "status": "正在写",
            "jumpTo": "jumpToWaveVC",
        ],
    ]

    let othersArray = [
        [
            "title": "下载的tool",
            "titleDescription": "自己写的下载的tool，有下载速度，进度，剩余时间，可以断点下载。暂不支持，后台下载，",
            "status": "待完善",
            "jumpTo": "jumpToNoDownloadVC",
        ],
        [
            "title": "浅学FMDB",
            "titleDescription": "TestDemo 没有主键，更新的时候，都不是根据主键来更改的",
            "status": "在写",
            "jumpTo": "jumpToFMDB",
        ],
        [
            "title": "ScrollManyTableViews",
            "titleDescription": "尝试",
            "status": "在写",
            "jumpTo": "jumpToScrollManyTableViewVC",
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupTabBarView()
    }

    private func setupTabBarView() {
        tabBar.backgroundColor = .clear
        customTabBar = CustomTabBar(frame: tabBar.bounds)
        customTabBar.clickTabs = { [weak self] tag in
            self?.selectedIndex = tag
        }
        tabBar.addSubview(customTabBar)
    }

    private func setupControllers() {

        let allDataArray = [
            functionsArray,
            funnyArray,
            othersArray,
        ]
        var controllers: Array<BaseNaviController> = []

        for index in 0 ..< allDataArray.count {

            let thisVC = ViewController.init(index: index, paramArray: allDataArray[index])
            let navi = BaseNaviController(rootViewController: thisVC)
            controllers.append(navi)
        }
        viewControllers = controllers
    }
}
