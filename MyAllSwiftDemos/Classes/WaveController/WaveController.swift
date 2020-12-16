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

        //        setupButton()
    }

    func setupButton() {
        let button = UIButton()
        button.setTitle("asadsad", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }

    @objc func clickButton() {
        self.navigationController?.pushViewController(FileController(), animated: true)
    }

    deinit {
        print("this wave controller will be deinit")
        waveView.removeFromSuperview()
        waveView.removeThisDisplayLink()
    }
}
