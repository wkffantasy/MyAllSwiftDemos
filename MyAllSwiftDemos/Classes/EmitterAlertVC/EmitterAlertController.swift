//
//  EmitterAlertController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/5/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class EmitterAlertController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .custom)
        button.setTitle("click this to show", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(clickThisButton), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }

    @objc func clickThisButton() {
        GetSuccessView().show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
