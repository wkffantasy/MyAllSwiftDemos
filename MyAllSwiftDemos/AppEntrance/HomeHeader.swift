//
//  HomeHeader.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class HomeHeader: UITableViewHeaderFooterView {

    private var titleLabel: UILabel!

    class func headerWithTableView(tableView: UITableView) -> HomeHeader {
        let headerId = "HomeHeader"
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        if header == nil {
            header = HomeHeader.init(reuseIdentifier: headerId)
        }
        return header as! HomeHeader
    }

    public func updateContent(text: String) {

        titleLabel.text = text
    }

    private override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.colorWithRGB(red: 220, green: 220, blue: 220)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {

        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.blue
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.init(name: "DINCond-Light", size: 17)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in

            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
}
