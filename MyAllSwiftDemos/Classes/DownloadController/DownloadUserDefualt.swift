//
//  DownloadUserDefualt.swift
//  MyAllSwiftDemos
//
//  Created by fantasy on 17/4/6.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class DownloadUserDefualt: NSObject {

    static let tool = DownloadUserDefualt()

    public func saveDownloadUrlAndData(url: String, resumeData: Data) {

        assert(url.length > 0, "")
        UserDefaults.standard.set(resumeData, forKey: converUrlToKey(url: url))
        UserDefaults.standard.synchronize()
    }

    public func fetchResumeData(url: String) -> Data? {
        assert(url.length > 0, "")
        let resumeData = UserDefaults.standard.object(forKey: converUrlToKey(url: url)) as? Data
        if resumeData == nil {
            return nil
        }
        return resumeData
    }

    public func removeItem(url: String) {
        assert(url.length > 0, "")
        UserDefaults.standard.removeObject(forKey: converUrlToKey(url: url))
        UserDefaults.standard.synchronize()
    }

    private func converUrlToKey(url: String) -> String {
        assert(url.length > 0, "")
        return "downloadUrlForUserDefaults~" + url
    }
}
