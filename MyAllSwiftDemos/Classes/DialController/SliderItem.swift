//
//  SliderItem.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class SliderItem: UIView {

    private var title:String!
    private var imageName:String!
    
    init(frame: CGRect,title:String!,imageName:String!) {
        super.init(frame: frame)
        assert(title.length>0,"")
        assert(imageName.length>0,"")
        backgroundColor = UIColor.randomColor()
        self.title = title
        self.imageName = imageName
        setupViews()
    }
    
    private func setupViews(){
        let imageView = UIImageView(image: UIImage.init(named: imageName))
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(41)
            make.top.equalTo(0)
            make.centerX.equalTo(self.snp.centerX)
        }
        let label = UILabel()
        label.textColor = UIColor.colorWithHexString("333333")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = title
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.right.left.equalTo(0)
            make.bottom.lessThanOrEqualTo(self.snp.bottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
