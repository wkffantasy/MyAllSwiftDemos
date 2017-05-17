//
//  SuccessView.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/17.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class SuccessView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10

        setViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews() {

        let label = UILabel()
        label.textColor = UIColor.colorWithHexString("333333")
        label.text = "恭喜你成为一个逗比"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.right.equalTo(-30)
            make.left.equalTo(30)
        }
    }
}
