//
//  TitleAndSubtileView.swift
//  toeflios
//
//  Created by fantasy on 17/5/26.
//  Copyright © 2017年 Facebook. All rights reserved.
//

import UIKit

class TitleAndSubtileView: UIView {

    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitleView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateTitle(title: String) {
        assert(title.length > 0, "")
        titleLabel.text = title
    }

    private func addTitleView() {
        let headerView = UIView()
        addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(0)
        }

        let titleView = UIView()
        headerView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.center.equalTo(headerView.snp.center)
        }

        titleLabel = UILabel()
        titleLabel.text = "选择我所在的年级"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.colorWithHexString("262435")
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.right.left.equalTo(0)
            make.centerX.equalTo(titleView.snp.centerX)
        }

        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "生成我的专属身份"
        subtitleLabel.textColor = UIColor.colorWithHexString("929292")
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        titleView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(0)
            make.centerX.equalTo(titleView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
}
