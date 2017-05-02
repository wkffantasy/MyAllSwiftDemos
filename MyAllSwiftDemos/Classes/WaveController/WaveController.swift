//
//  WaveController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/17.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class WaveController: UIViewController {

    var waveView = WaveView(frame: CGRect(x: 0, y: 164, width: ScreenWidth, height: 25))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(waveView)
    }

    deinit {
        print("this wave controller will be deinit")
        waveView.removeFromSuperview()
        waveView.removeThisDisplayLink()
    }
}
