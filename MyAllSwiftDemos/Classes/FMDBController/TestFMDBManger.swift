//
//  TestFMDBManger.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/3/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import FMDB
/// test
/// progress  totalCount currentCount
class TestFMDBManger: NSObject {

    static let tool = TestFMDBManger()

    let fileURL = try! FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("test.sqlite")

    var database: FMDatabase!

    // open dataBase and create table
    public func openDatabase(successBlock: StringParamBlock?, failedBlock: StringParamBlock?) {
        database = FMDatabase(path: fileURL.path)
        if database.open() {
            if successBlock != nil {
                successBlock!("success")
            }
        } else {
            if failedBlock != nil {
                failedBlock!("failed")
            }
        }

        do {
            try database.executeUpdate("create table if not exists test(progress text,totalCount integer,currentCount integer)", values: nil)
        } catch {
//            log.error("failed : \(error.localizedDescription)")
        }
    }

    // add an item
    public func addItem(progress: String, totalCount: Int64, currentCount: Int64) {

        assert(progress.length > 0, "")
        do {
            try database.executeUpdate("insert into test(progress,totalCount,currentCount) values(?,?,?)", values: [progress, totalCount, currentCount])
        } catch {
//            log.error("failed : \(error.localizedDescription)")
        }
    }

    // delete an item according to currentCount when currentCount equal sth
    public func deleteItemAccordingToCurrentCount(currentCount: Int64) {
        let executeString = "delete from test where currentCount = " + String(currentCount)
        do {
            try database.executeUpdate(executeString, values: nil)
        } catch {
//            log.error("failed : \(error.localizedDescription)")
        }
    }

    // update an item according to currentCount when currentCount equal sth,then update progress
    public func updateItem(thisCurrentCount: Int64, willUpdateProgress: String) {
        assert(willUpdateProgress.length > 0, "")
        let executeString = String(format: "update test set progress = '%@' where currentCount = '%@'", willUpdateProgress, String(thisCurrentCount))
        do {
            try database.executeUpdate(executeString, values: nil)
        } catch {
//            log.error("failed : \(error.localizedDescription)")
        }
    }

    // find all items in test table
    public func findAllItems() -> Array<TestModel>? {
        do {
            var thisArray = Array<TestModel>()
            let rs = try database.executeQuery("select progress,totalCount,currentCount from test", values: nil)
            while rs.next() {
                if let progress = rs.string(forColumn: "progress"), let totalCount = rs.string(forColumn: "totalCount"), let currentCount = rs.string(forColumn: "currentCount") {
                    let model = TestModel()
                    model.progress = progress
                    model.totalCount = Int64(totalCount)
                    model.currentCount = Int64(currentCount)
                    thisArray.append(model)
                }
            }
            return thisArray

        } catch {
//            log.error("failed : \(error.localizedDescription)")
            return nil
        }
    }

    public func closeThis() {
        database.close()
    }
}
