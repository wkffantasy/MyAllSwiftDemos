//
//  DownloadFMDBManger.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/4/5.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

import FMDB

class DownloadFMDBManger: NSObject {

    static let tool = DownloadFMDBManger()
    let fileURL = try! FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("download.sqlite")

    var database: FMDatabase!

    // open dataBase and create table
    public func openDatabase(successBlock: StringParamBlock?, failedBlock: StringParamBlock?) {
        database = FMDatabase(path: fileURL.path)
        if database.open() {

            // warming
            findAllItems()

            if successBlock != nil {
                successBlock!("success")
            }
        } else {
            if failedBlock != nil {
                failedBlock!("failed")
            }
        }

        do {
            try database.executeUpdate("create table if not exists DOWNLOAD(url text not null,resumeData text)", values: nil)
        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    // close database
    public func closeThis() {
        assert(database != nil, "")
        database.close()
    }

    // add an item
    public func addItem(downloadUrl: String, resumeData: Data) {

        assert(downloadUrl.length > 0, "")
        // 先查
        let thisResumeData = lookIntoAnItemAccordingUrl(downloadUrl: downloadUrl)

        if thisResumeData == nil { // 如果没有 insert
            do {
                try database.executeUpdate("insert into DOWNLOAD(url,resumeData) values(?,?)", values: [downloadUrl, dataToString(resumeData: resumeData)])
            } catch {
                log.error("insert failed : \(error.localizedDescription)")
            }

        } else { // 如果有 update
            updateItem(downloadUrl: downloadUrl, resumeData: resumeData)
        }

        // warming
        findAllItems()
    }

    // delete an item according to url
    public func deleteItemAccordingToUrl(downloadUrl: String) {
        let executeString = "delete from DOWNLOAD where url = " + String(downloadUrl)
        do {
            try database.executeUpdate(executeString, values: nil)
        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    // update an item according to url
    public func updateItem(downloadUrl: String, resumeData: Data) {
        assert(downloadUrl.length > 0, "")
        let executeString = String(format: "update DOWNLOAD set resumeData = '%@' where url = '%@'", dataToString(resumeData: resumeData)!, downloadUrl)
        do {
            try database.executeUpdate(executeString, values: nil)
        } catch {
            log.error("failed : \(error.localizedDescription)")
        }
    }

    public func lookIntoAnItemAccordingUrl(downloadUrl: String) -> Data? {

        // warming
        findAllItems()

        assert(downloadUrl.length > 0, "")
        do {
            let executeString = String(format: "select url from DOWNLOAD where url = '%@'", downloadUrl)
            let rs = try database.executeQuery(executeString, values: nil)
            while rs.next() {
                let data = rs.string(forColumn: "resumeData")
                if data != nil {
                    print("data ==", data)
                    return stringToData(resumeString: data!)
                }
            }
            return nil

        } catch {
            log.error("failed : \(error.localizedDescription)")
            return nil
        }

        return nil
    }

    // find all items in DOWNLOAD table
    public func findAllItems() -> Array<DownloadFMDBModel>? {
        do {
            var thisArray = Array<DownloadFMDBModel>()
            let rs = try database.executeQuery("select url,resumeData from DOWNLOAD", values: nil)
            while rs.next() {
                if let url = rs.string(forColumn: "url"), let resumeData = rs.string(forColumn: "resumeData") {
                    let model = DownloadFMDBModel()
                    model.url = url
                    model.resumeData = stringToData(resumeString: resumeData)
                    print("all items url ==", url)
                    thisArray.append(model)
                }
            }
            return thisArray

        } catch {
            log.error("failed : \(error.localizedDescription)")
            return nil
        }
    }

    private func dataToString(resumeData: Data) -> String? {
        let string = NSString(data: resumeData, encoding: String.Encoding.utf8.rawValue)
        return string as String?
    }

    private func stringToData(resumeString: String) -> Data? {
        let data = resumeString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        return data
    }
}
