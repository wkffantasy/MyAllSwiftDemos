//
//  VideoTopMenu.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/14.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class VideoTopMenu: UIView {
    
    var titleLabel:UILabel!
    
    var playTitle:String! {
        
        didSet{
            assert(playTitle.length > 0 ,"")
            log.verbose("give top view title \(playTitle)")
            titleLabel.text = playTitle
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithHexString("000000", Alpha: 0.7)
        setupViews()
    }
    
    private func setupViews(){
        
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.colorWithHexString("f2f2f2")
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
