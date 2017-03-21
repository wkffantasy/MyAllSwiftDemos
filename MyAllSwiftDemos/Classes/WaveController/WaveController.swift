//
//  WaveController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/17.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class WaveController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let waveView = WaveView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: 200))
        self.view.addSubview(waveView)
    }
}
