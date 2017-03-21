//
//  HomeCell.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/13.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var statusLabel: UILabel!
    private let margin = 20

    class func cellWithTableView(tableView: UITableView) -> HomeCell {

        let cellId = "HomeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {

            cell = HomeCell.init(style: .default, reuseIdentifier: cellId)
        }
        return cell as! HomeCell
    }

    public func assignItData(model: HomeModel) {

        titleLabel.text = model.title
        statusLabel.text = model.status
        descriptionLabel.text = model.titleDescription
    }

    private override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {

        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.colorWithHexString("454545")
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in

            make.left.equalTo(margin)
            make.top.equalTo(10)
        }

        statusLabel = UILabel.init()
        statusLabel.textColor = UIColor.red
        statusLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in

            make.right.equalTo(-margin)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(20).priority(.low)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }

        descriptionLabel = UILabel.init()
        descriptionLabel.textColor = UIColor.colorWithHexString("666666")
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(margin)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(-margin)
        }

        let sepView = UIView.init()
        sepView.backgroundColor = UIColor.colorWithRGB(red: 230, green: 230, blue: 230)
        self.addSubview(sepView)
        sepView.snp.makeConstraints { make in
            make.left.equalTo(margin)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.right.equalTo(self.snp.right).offset(-margin)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
