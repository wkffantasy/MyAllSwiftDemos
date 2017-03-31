//
//  BaseNaviController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/31.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class BaseNaviController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
