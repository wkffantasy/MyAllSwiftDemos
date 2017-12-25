
//  NoMarginScrollController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class NoMarginScrollController: UIViewController {

    let rollWidth = ScreenWidth
    let rollHeight = ScreenWidth * 40 / 64
    var rollView1: NoMarginRollingView!
    var tipLabel: UILabel!
    var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        setupView1()
    }

    func setupView1() {

        var imageArray: Array<String> = []
        for index in 0 ..< 4 {
            let imageName = String(format: "%02d", index + 1)
            imageArray.append(imageName)
        }
        let rollRect = CGRect(x: 0, y: 64, width: rollWidth, height: rollHeight)
        rollView1 = NoMarginRollingView.init(frame: rollRect, imageArray: imageArray, time: 3)

        rollView1.clickButtonBlock = { [weak self] tag in
//            log.debug("click this image tag == \(tag)")
            self?.tipLabel.text = "点击了第\(tag)张图片"
        }
        rollView1.currentIndexBlock = { [weak self] tag in
            self?.pageControl.currentPage = tag
        }

        self.view.addSubview(rollView1)

        tipLabel = UILabel.init()
        tipLabel.text = "还没点击"
        tipLabel.textAlignment = .center
        tipLabel.textColor = UIColor.colorWithHexString("333333")
        self.view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.right.left.equalTo(0)
            make.top.equalTo(rollView1.snp.bottom).offset(14)
        }

        pageControl = UIPageControl.init()
        rollView1.addSubview(pageControl)
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.numberOfPages = imageArray.count
        pageControl.snp.makeConstraints { make in

            make.left.right.bottom.equalTo(0)
            make.height.equalTo(20)
        }
    }

    deinit {
        rollView1.removeTimer()
    }
}
