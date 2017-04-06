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
    
    public func saveDownloadUrlAndData(url:String,resumeData:Data){
        
        assert(url.length>0,"")
        
        UserDefaults.standard.set(dataToString(resumeData: resumeData), forKey: converUrlToKey(url: url))
        UserDefaults.standard.synchronize()
    
    }
    public func fetchResumeData(url:String)->Data?{
        assert(url.length>0,"")
        let resumeDataString = UserDefaults.standard.object(forKey: converUrlToKey(url: url)) as? String
        if resumeDataString == nil {
            return nil
        }
        return stringToData(resumeString: resumeDataString!)
    }
    
    public func removeItem(url:String){
        assert(url.length>0,"")
        UserDefaults.standard.removeObject(forKey: converUrlToKey(url: url))
        UserDefaults.standard.synchronize()
    }
    
    private func converUrlToKey(url:String)->String{
        assert(url.length > 0 ,"")
        return "downloadUrlForUserDefaults~" + url
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
