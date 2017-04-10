//
//  ScrollManyTabsViewController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/4/7.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class ScrollManyTabsViewController: UIViewController {

    lazy var headImageView:UIImageView = {
        
        let headerImage = UIImageView()
        headerImage.image = UIImage.init(named: "01")
        headerImage.frame = CGRect(x:0,y:64,width:ScreenWidth,height:ScreenWidth*40/64)
        return headerImage
        
    }()
    
    lazy var tabsSelectView :TabsSelectView = {
        
        let titleArray = [
            "发如雪",
            "青花瓷",
            "东风破",
            ]
        let returnView = TabsSelectView.init(titleArray: titleArray, frame: CGRect(x:0,y:ScreenWidth*40/64+64,width:ScreenWidth,height:44), selectColor: UIColor.colorWithRGB(red: 74, green: 153, blue: 255), normalColor: UIColor.colorWithRGB(red: 134, green: 134, blue: 134))
        returnView.clickButtonBlock = { (tag:Int)in
            print("clickButtonBlock tag ==",tag)
        }
        return returnView
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(headImageView)
        view.addSubview(tabsSelectView)
        
        
    }

}
