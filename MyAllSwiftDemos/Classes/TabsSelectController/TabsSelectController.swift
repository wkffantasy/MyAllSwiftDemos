//
//  TabsSelectController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class TabsSelectController: UIViewController, UIScrollViewDelegate {

    // 为true 是文字 为false 是图片
    public var isTitle: Bool!

    var tabsSelectView: TabsSelectView!
    var vcScrollView: UIScrollView!

    init(isTitle: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isTitle = isTitle
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupViews()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let contentOffset = scrollView.contentOffset
        let scrollFrame = scrollView.frame
        let page = contentOffset.x / scrollFrame.size.width
        self.tabsSelectView.updateButtonState(tag: Int(page))
    }

    func letItScroll(tag: Int) {
        let scrollWidth = self.vcScrollView.frame.size.width
        self.vcScrollView.setContentOffset(CGPoint(x: scrollWidth * CGFloat(tag), y: 0), animated: true)
    }

    func setupViews() {

        if self.isTitle == true {

            let titleArray = [
                "发如雪",
                "青花瓷",
                "东风破",
            ]
            tabsSelectView = TabsSelectView.init(titleArray: titleArray, frame: CGRect.zero, selectColor: UIColor.colorWithRGB(red: 74, green: 153, blue: 255), normalColor: UIColor.colorWithRGB(red: 134, green: 134, blue: 134))

        } else {

            let imageNormalArray = [
                "message_notificationNomal",
                "message_responseNormal",
                "message_zanNormal",
            ]
            let imageSelectArray = [
                "message_notificationSeleted",
                "message_responseSelected",
                "message_zanSelected",
            ]
            tabsSelectView = TabsSelectView.init(frame: CGRect.zero, selectImageArray: imageSelectArray, normalImageArray: imageNormalArray)
        }

        self.view.addSubview(tabsSelectView)
        tabsSelectView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.height.equalTo(40)
            make.top.equalTo(64)
        }
        tabsSelectView.clickButtonBlock = { [weak self] (tag: Int) in
            self?.letItScroll(tag: tag)
        }

        vcScrollView = UIScrollView.init()
        vcScrollView.showsHorizontalScrollIndicator = false
        vcScrollView.isPagingEnabled = true
        vcScrollView.delegate = self
        vcScrollView.bounces = false
        self.view.addSubview(vcScrollView)
        vcScrollView.snp.makeConstraints { make in
            make.top.equalTo(tabsSelectView.snp.bottom)
            make.bottom.right.left.equalTo(0)
        }

        let containerView = UIView.init()
        vcScrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(vcScrollView)
            make.width.greaterThanOrEqualTo(vcScrollView)
            make.height.equalTo(vcScrollView.snp.height)
        }

        let t1VC = TestOneController()
        let t2VC = TestTwoController()
        let t3VC = TestThreeController()

        self.addChild(t1VC)
        self.addChild(t2VC)
        self.addChild(t3VC)

        containerView.addSubview(t1VC.view)
        containerView.addSubview(t2VC.view)
        containerView.addSubview(t3VC.view)

        t1VC.view.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(vcScrollView.snp.width)
        }
        t2VC.view.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.width.equalTo(vcScrollView.snp.width)
            make.left.equalTo(t1VC.view.snp.right)
        }
        t3VC.view.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.width.equalTo(vcScrollView.snp.width)
            make.left.equalTo(t2VC.view.snp.right)
            make.right.equalTo(containerView.snp.right)
        }
    }
}
