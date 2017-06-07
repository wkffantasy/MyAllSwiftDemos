//
//  CloudController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/6/3.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class CloudController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
        let animateView = AnimateMoveView()
        self.view.addSubview(animateView)
        animateView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(64)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
