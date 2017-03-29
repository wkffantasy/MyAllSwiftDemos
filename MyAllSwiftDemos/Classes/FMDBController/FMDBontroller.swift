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

    let fileURL = try! FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("test.sqlite")

    var database: FMDatabase!

    override func viewDidLoad() {
        super.viewDidLoad()
        database = FMDatabase(path: self.fileURL.path)
        if database.open() {
            print("打开数据库成功")
        } else {
            print("打开数据库失败")
        }
    }

    @IBAction func clickToAddItem(_: UIButton) {
        print("clickToAddItem")
        do {
            try database.executeUpdate("create table test(progress text,totalCount integer,currentCount integer)", values: nil)
            try database.executeUpdate("insert into test(progress,totalCount,currentCount) values(?,?,?)", values: ["50%", 2, 1])
            try database.executeUpdate("insert into test(progress,totalCount,currentCount) values(?,?,?)", values: ["20%", 10, 2])
            try database.executeUpdate("insert into test(progress,totalCount,currentCount) values(?,?,?)", values: ["100%", 10, 10])

        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    @IBAction func clickToDelete(_: UIButton) {
        print("clickToDelete")
        do {
            try database.executeUpdate("delete from test where currentCount = 5", values: nil)
        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    @IBAction func clickToChange(_: UIButton) {
        print("clickToChange")
        do {
            try database.executeUpdate("update test set progress = '30%' where currentCount = 2", values: ["30%"])
        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    @IBAction func clickToFindItem(_: UIButton) {
        print("clickToFindItem")
        do {
            let rs = try database.executeQuery("select progress,totalCount,currentCount from test", values: nil)
            while rs.next() {
                if let progress = rs.string(forColumn: "progress"), let totalCount = rs.string(forColumn: "totalCount"), let currentCount = rs.string(forColumn: "currentCount") {
                    print("progress ==", progress, "totalCount ==", totalCount, "currentCount ==", currentCount)
                }
            }

        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    @IBAction func clickToAddSecondItem(_: UIButton) {
        print("clickToAddSecondItem")
        do {
            try database.executeUpdate("insert into test(progress,totalCount,currentCount) values(?,?,?)", values: ["50%", 10, 5])
        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    deinit {
        database.close()
        log.warning("this FMDB controller will be deinit")
    }
}
