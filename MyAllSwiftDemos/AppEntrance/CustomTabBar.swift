//
//  CustomTabBar.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/31.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class CustomTabBar: UIView {

    public var clickTabs: IntParamBlock?

    private var selectedItem: UIView?
    private let titlesArray = ["Views", "Funny", "Others"]
    private let imageNormalArray = [
        "message_notificationNomal",
        "message_responseNormal",
        "message_zanNormal",
    ]
    private let imageSelectArray = [
        "message_notificationSeleted",
        "message_responseSelected",
        "message_zanSelected",
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.colorWithRGB(red: 240, green: 240, blue: 240)
        self.isUserInteractionEnabled = true
        setupViews()
        
        let line = UIView()
        line.backgroundColor = UIColor.colorWithRGB(red: 222, green: 222, blue: 222)
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(1)
        }
    }

    private func setupViews() {

        let itemW = ScreenWidth / CGFloat(titlesArray.count)
        for index in 0 ..< titlesArray.count {
            let itemView = UIView()
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(tap:)))
            itemView.addGestureRecognizer(tap)
            itemView.tag = index
            addSubview(itemView)
            itemView.snp.makeConstraints({ make in
                make.top.bottom.equalTo(0)
                make.width.equalTo(itemW)
                make.left.equalTo(CGFloat(index) * itemW)
                //                if itemView.tag == titlesArray.count - 1 {
                //                    make.right.equalTo(self.snp.right)
                //                }
            })

            let imageView = UIImageView()
            imageView.tag = 100
            imageView.image = UIImage(named: imageNormalArray[index])
            itemView.addSubview(imageView)
            imageView.snp.makeConstraints({ make in
                make.top.equalTo(itemView.snp.top).offset(10)
                make.centerX.equalTo(itemView.snp.centerX)
                make.height.width.equalTo(15)
            })

            let label = UILabel()
            label.textColor = UIColor.colorWithRGB(red: 142, green: 142, blue: 147)
            label.font = UIFont.systemFont(ofSize: 10)
            label.tag = 101
            label.text = titlesArray[index]
            itemView.addSubview(label)
            label.snp.makeConstraints({ make in
                make.top.equalTo(imageView.snp.bottom).offset(5)
                make.centerX.equalTo(itemView.snp.centerX)
            })

            if index == 0 {
                selectedItem = itemView
                imageView.image = UIImage(named: imageSelectArray[index])
                label.textColor = UIColor.colorWithRGB(red: 248, green: 150, blue: 1)
            }
        }
    }

    func tapItem(tap: UITapGestureRecognizer) {

        let thisItem = tap.view
        if selectedItem == thisItem {
            return
        }
        let imageView1 = selectedItem?.viewWithTag(100) as! UIImageView
        let label1 = selectedItem?.viewWithTag(101) as! UILabel
        label1.textColor = UIColor.colorWithRGB(red: 142, green: 142, blue: 147)
        imageView1.image = UIImage(named: imageNormalArray[(selectedItem?.tag)!])

        selectedItem = thisItem

        let imageView2 = thisItem?.viewWithTag(100) as! UIImageView
        let label2 = thisItem?.viewWithTag(101) as! UILabel
        label2.textColor = UIColor.colorWithRGB(red: 248, green: 150, blue: 1)
        imageView2.image = UIImage(named: imageSelectArray[(selectedItem?.tag)!])

        if self.clickTabs != nil {
            self.clickTabs!((thisItem?.tag)!)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
