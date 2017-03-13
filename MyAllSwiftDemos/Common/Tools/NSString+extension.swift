//
//  NSString+extension.swift
//  BaseProjectSwift3.0
//
//  Created by 雅昌－一粒 on 16/10/10.
//  Copyright © 2016年 artron. All rights reserved.
//

import Foundation
extension String {
    var length: Int {
        return self.characters.count
    }

    var OCString: NSString {
        return self as NSString
    }

    var lastPathComponent: String {
        return self.OCString.lastPathComponent
    }

    var pathExtension: String {
        return self.OCString.pathExtension
    }

    var base64: String? {

        let plainData = data(using: String.Encoding.utf8)
        return plainData?.base64EncodedString()
    }

    // 解码
    var base64Decode: String? {

        let decodeData = Data(base64Encoded: self)
        if let data = decodeData {
            return String.init(data: data, encoding: String.Encoding.utf8)
        } else {
            return nil
        }
    }

    func appendingPathComponent(component: String) -> String {
        return self.OCString.appendingPathComponent(component) as String
    }

    static func isNullOrEmpty(str: String?) -> Bool {
        if str == nil {
            return true
        }
        if str!.isEmpty {
            return true
        }
        return false
    }

    /**

     按位置截取字符
     start: 开始位置，start 为正数
     end: 结束位置，end 可正负
     */

    func subString(start: Int, end: Int = 0) -> String {

        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.endIndex, offsetBy: end > 0 ? end - self.length : end)
        let range = Range<String.Index>(startIndex ..< endIndex)

        return self.substring(with: range)
    }

    /**
     按个数截取字符
     start: 开始位置，正数为：从开头截取，负数：从末尾截取
     number: 截取的个数
     */
    func subString(start: Int, length: Int) -> String {

        if start > 0 {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: length + start)
            let range = Range<String.Index>(startIndex ..< endIndex)
            return self.substring(with: range)
        } else {
            let startIndex = self.index(self.endIndex, offsetBy: start)
            let endIndex = self.index(self.endIndex, offsetBy: -length + start)
            let range = Range<String.Index>(endIndex ..< startIndex)
            return self.substring(with: range)
        }
    }

    /**
     从头截取到参数位置的字符串

     */
    func subStringTo(to: Int) -> String {

        let endIndex = to > 0 ? self.index(self.startIndex, offsetBy: to) : self.index(self.endIndex, offsetBy: to)
        return self.substring(to: endIndex)
    }

    /**
     从参数位置截取到末尾的字符串
     */
    func SubStringFrom(from: Int) -> String {
        let endIndex = from > 0 ? self.index(self.startIndex, offsetBy: from) : self.index(self.endIndex, offsetBy: from)
        return self.substring(from: endIndex)
    }

    /**
     *  字符串是否为空
     *
     *  @param string 字符串
     *
     *  @return YES/NO
     */

    func isBlankString() -> Bool {
        if self == "" || self.characters.count == 0 {
            return true
        }
        if self.trimmingCharacters(in: NSCharacterSet.whitespaces).length == 0 {
            return true
        }
        return false
    }

    func stringNSPredicate(Regex: String) -> Bool {
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", Regex)
        return phoneTest.evaluate(with: self)
    }

    /**
     *  验证手机号是否正确
     *
     *  @param mobile 手机号
     *
     *  @return YES/NO
     */
    func isMobileNumber() -> Bool {
        return stringNSPredicate(Regex: "^(1[3456789]{1})\\d{9}$")
    }

    /**
     *  验证一段文字是否都为数字
     *
     *  @param string 文字
     *
     *  @return YES / NO
     */
    func isAllNumberString() -> Bool {
        return stringNSPredicate(Regex: "^[0-9]*$")
    }

    /**
     *  判断是否包含某一短文字：hgm---因为containsString函数在ios8以上
     *
     *  @param str 比较的字段
     *
     *  @return 是否包含
     */

    func containsStringWithOtherStr(str: String) -> Bool {

        if self == str {
            return true
        }
        if self.components(separatedBy: str).count > 1 {
            return true
        } else {
            return false
        }
    }

    // MAKE---------Base64---------
    /**
     解码base64

     - parameter string: base64的文字

     - returns: 返回string
     */
    func decodeBase64String() -> String {
        let decodedData = Data(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        if decodedData == nil {
            return ""
        }
        let decideString = String(data: decodedData!, encoding: String.Encoding.utf8)
        return decideString!
    }

    /**
     编码64

     - parameter string: 需要编码的文字

     - returns: 返回编码后的文字
     */
    func encodeBase64String() -> String {
        let plainData = self.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }

    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}
