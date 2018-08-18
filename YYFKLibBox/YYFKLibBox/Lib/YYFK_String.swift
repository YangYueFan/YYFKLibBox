//
//  YYFK_String.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

extension String {
    /// 字符串的第一个字符
    var firstString: String {
        
        return self.substringTo(0)
    }
    
    /// 字符串的最后一个字符
    var lastString: String {
        
        return self.substringFrom(self.count - 1)
    }
    
    /// 字符串开始到第index
    ///
    /// - Parameter index: 结束索引
    /// - Returns: 子字符串
    func substringTo(_ index: Int) -> String {
        
        guard index < self.count else {
            assertionFailure("index beyound the length of the string")
            return ""
        }
        
        let theIndex = self.index(self.startIndex, offsetBy: index)
        
        return String(self[startIndex...theIndex])
    }
    
    /// 从第index个开始到结尾的字符
    ///
    /// - Parameter index: 开始索引
    /// - Returns: 子字符串
    func substringFrom(_ index: Int) -> String {
        
        guard index < self.count else {
            assertionFailure("index beyound the length of the string")
            return ""
        }
        
        guard index >= 0 else {
            assertionFailure("index can't be lower than 0")
            return ""
        }
        
        let theIndex = self.index(self.endIndex, offsetBy: index - self.count)
        
        return String(self[theIndex..<endIndex])
    }
    
    /// 某个闭区间内的字符
    ///
    /// - Parameter range: 闭区间，例如：1...6
    /// - Returns: 子字符串
    func substringInRange(_ range: CountableClosedRange<Int>) -> String {
        
        guard range.lowerBound >= 0 else {
            assertionFailure("lowerBound of the Range can't be lower than 0")
            return ""
        }
        
        guard range.upperBound < self.count else {
            assertionFailure("upperBound of the Range beyound the length of the string")
            return ""
        }
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound + 1)
        
        return String(self[start..<end])
    }
    
    /// 手机号字符串隐藏中间部分数字
    mutating func hiddenTelphone() {
        
        if self.count != 11 {
            return ;
        }
        
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.endIndex, offsetBy: -4)
        
        let range = Range.init(uncheckedBounds: (lower: start, upper: end))
        
        self.replaceSubrange(range, with: "****")
    }
    
    
    
    
    /// 判断 邮箱
    func isValidEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 判断 手机号
    func isValidMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9])|(19[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    /// 判断 密码
    func isValidPassword() -> Bool {
        let  passWordRegex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES%@", passWordRegex)
        return passWordPredicate.evaluate(with: self)
    }
    
    /// 判断 昵称
    func isValidNickname() -> Bool {
        let nicknameRegex = "^[\u{4e00}-\u{9fa5}]{4,8}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES%@", nicknameRegex)
        return passWordPredicate.evaluate(with: self)
    }
    
    /// 判断 车牌号
    func isValidCarNum() -> Bool {
        let carString = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
        let carPredicate = NSPredicate(format: "SELF MATCHES %@", carString)
        return carPredicate.evaluate(with: self)
    }
    
    
    /// 判断 用户名
    func isValidUserName() -> Bool {
        let userNameRegex = "^[A-Za-z0-9]{6,20}+$"
        let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
        let peopleName = userNamePredicate.evaluate(with: self)
        return peopleName
    }
    

    

}
