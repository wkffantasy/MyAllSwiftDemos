//
//  FMDBontroller.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit
import FMDB

class FMDBontroller: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        TestFMDBManger.tool.openDatabase(successBlock: { (success) in
            print("打开数据库成功")
        }) { (failed) in
            print("打开数据库失败")
        }
    }

    @IBAction func clickToAddItem(_: UIButton) {
        print("clickToAddItem")
        TestFMDBManger.tool.addItem(progress: "1%", totalCount: 20, currentCount: 1)
        TestFMDBManger.tool.addItem(progress: "2%", totalCount: 20, currentCount: 2)
    }

    @IBAction func clickToDelete(_: UIButton) {
        print("clickToDelete")
        TestFMDBManger.tool.deleteItemAccordingToCurrentCount(currentCount: 1)
        TestFMDBManger.tool.deleteItemAccordingToCurrentCount(currentCount: 2)
    }

    @IBAction func clickToChange(_: UIButton) {
        print("clickToChange")
        TestFMDBManger.tool.updateItem(thisCurrentCount: 5, willUpdateProgress: "111%")
    }

    @IBAction func clickToFindItem(_: UIButton) {
        print("clickToFindItem")
        let array:Array<TestModel>? = TestFMDBManger.tool.findAllItems()
        for model in array! {
            print("progress ==",model.progress,"totalCount ==",model.totalCount,"currentCount ==",model.currentCount)
        }
    }

    @IBAction func clickToAddSecondItem(_: UIButton) {
        print("clickToAddSecondItem")
        TestFMDBManger.tool.addItem(progress: "5%", totalCount: 20, currentCount: 5)
    }

    deinit {
        TestFMDBManger.tool.closeThis()
        log.warning("this FMDB controller will be deinit")
    }
}
