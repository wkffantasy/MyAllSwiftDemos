//
//  CompanyAnimateController.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/6/3.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class CompanyAnimateController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let learnView = LearnIntentionView()
        learnView.callBackToRN = {[weak self](paramDict,view)in
            self?.navigationController?.popViewController(animated: true)
            print("paramDict ==",paramDict)
        }
        
        self.view.addSubview(learnView)
        learnView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
