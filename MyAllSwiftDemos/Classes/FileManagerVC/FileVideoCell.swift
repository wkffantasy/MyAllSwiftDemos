//
//  FileVideoCell.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/11.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class FileVideoCell: UITableViewCell {

    private var titleLabel: UILabel!
    private let margin = 20
    
    class func cellWithTableView(tableView: UITableView) -> FileVideoCell {
        
        let cellId = "FileVideoCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            
            cell = FileVideoCell.init(style: .default, reuseIdentifier: cellId)
        }
        return cell as! FileVideoCell
    }
    
    public func assignItData(title:String) {
        
        titleLabel.text = title
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
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.top.equalTo(10)
        }
        
        let sepView = UIView.init()
        sepView.backgroundColor = UIColor.colorWithRGB(red: 230, green: 230, blue: 230)
        self.addSubview(sepView)
        sepView.snp.makeConstraints { make in
            make.left.equalTo(margin)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(self.snp.right).offset(-margin)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }


}
