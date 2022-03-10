//
//  String+Utils.swift
//  greeMall
//
//  Created by jsjzx on 2020/7/21.
//  Copyright © 2020 com.gree. All rights reserved.
//

import Foundation


extension String {
    
    //字典转Data
    static func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("is not a valid json object")
            return nil
        }
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        //Data转换成String打印输出
        let str = String(data:data!, encoding: String.Encoding.utf8)
        //输出json字符串
        print("Json Str:\(str!)")
        return data
    }
    
    //数组转Data
    static func ArrayToData(paramArray: Array<Any>) -> Data? {
        if (!JSONSerialization.isValidJSONObject(paramArray)) {
            print("无法解析出JSONString")
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: paramArray, options: [])
        let JSONString = String(data:data!, encoding: String.Encoding.utf8)
        //输出json字符串
        print("JSONString:\(JSONString!)")
        return data
    }

    //手机邮件脱敏处理
    func desensitizationForString(type: Int) -> String {
        
        if type == 2 {
            //邮箱脱敏
            if self.lengthOfBytes(using: .utf8) > 5 {
                let start = self.index(self.startIndex, offsetBy: 0)
                let end = self.index(self.startIndex, offsetBy: 3)
                let range = Range(uncheckedBounds: (lower: start, upper: end))
                return self.replacingCharacters(in: range, with: "****")
            } else {
                return self
            }
        } else {
            //手机号脱敏
            if self.lengthOfBytes(using: .utf8) > 10 {
                let start = self.index(self.startIndex, offsetBy: 3)
                let end = self.index(self.startIndex, offsetBy: 7)
                let range = Range(uncheckedBounds: (lower: start, upper: end))
                return self.replacingCharacters(in: range, with: "****")
            } else {
                return self
            }
        }
    }
    
    // 脱敏处理
    func desensitizationForString() ->String {
        var desStr = self
        
        if self.count == 1 {
            desStr = self + "****"
        } else if self.count == 2 {
            guard let rang = Range(NSRange(location: 1, length: 1), in: self) else {
                return desStr
            }
            desStr = self.replacingCharacters(in: rang, with: "****")
        } else if self.count == 3 {
            
            let start = self.index(self.startIndex, offsetBy: 1)
            let end = self.index(self.startIndex, offsetBy: 2)
            let rang = Range(uncheckedBounds: (lower: start, upper: end))
            desStr = self.replacingCharacters(in: rang, with: "****")
        } else if self.count > 3 && self.count < 8 {
            let index = self.count / 2
            let start = self.index(startIndex, offsetBy: index - 1)
            let end = self.index(startIndex, offsetBy: index + 1)
            let rang = Range(uncheckedBounds: (lower: start, upper: end))
            desStr = self.replacingCharacters(in: rang, with: "****")
        } else { // self.count >= 8
            let start = self.index(self.startIndex, offsetBy: 4)
            let end = self.index(startIndex, offsetBy: 8)
            let rang = Range(uncheckedBounds: (lower: start, upper: end))
            desStr = self.replacingCharacters(in: rang, with: "****")
        }
        return desStr
    }
    
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    //JSONString转为字典、数组
    func JsonStringToAny() -> Any? {
        let jsonData: Data = self.data(using: .utf8) ?? Data()
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        return dict
    }
    
    /*!
     验证身份证
     
     - returns: true/false
     */
    
    func checkIdentityCardNumber(_ number: String) -> Bool {
        //判断位数
        if number.count != 15 && number.count != 18 {
            return false
        }
        var carid = number
        
        var lSumQT = 0
        
        //加权因子
        let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        
        //校验码
        let sChecker: [Int8] = [49,48,88, 57, 56, 55, 54, 53, 52, 51, 50]
        
        //将15位身份证号转换成18位
        let mString = NSMutableString.init(string: number)
        
        if number.count == 15 {
            mString.insert("19", at: 6)
            var p = 0
            let pid = mString.utf8String
            for i in 0...16 {
                let t = Int(pid![i])
                p += (t - 48) * R[i]
            }
            let o = p % 11
            let stringContent = NSString(format: "%c", sChecker[o])
            mString.insert(stringContent as String, at: mString.length)
            carid = mString as String
        }
        
        let cStartIndex = carid.startIndex
        let _ = carid.endIndex
        let index = carid.index(cStartIndex, offsetBy: 2)
        //判断地区码
        let sProvince = String(carid[cStartIndex..<index])
        if (!self.areaCodeAt(sProvince)) {
            return false
        }
        
        //判断年月日是否有效
        //年份
        let yStartIndex = carid.index(cStartIndex, offsetBy: 6)
        let yEndIndex = carid.index(yStartIndex, offsetBy: 4)
        let strYear = Int(carid[yStartIndex..<yEndIndex])
        
        //月份
        let mStartIndex = carid.index(yEndIndex, offsetBy: 0)
        let mEndIndex = carid.index(mStartIndex, offsetBy: 2)
        let strMonth = Int(carid[mStartIndex..<mEndIndex])
        
        //日
        let dStartIndex = carid.index(mEndIndex, offsetBy: 0)
        let dEndIndex = carid.index(dStartIndex, offsetBy: 2)
        let strDay = Int(carid[dStartIndex..<dEndIndex])
        
        let localZone = NSTimeZone.local
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = localZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: "\(String(format: "%02d",strYear!))-\(String(format: "%02d",strMonth!))-\(String(format: "%02d",strDay!)) 12:01:01")
        
        if date == nil {
            return false
        }
        let paperId = carid.utf8CString
        //检验长度
        if 18 != carid.count {
            return false
        }
        //校验数字
        func isDigit(c: Int) -> Bool {
            return 0 <= c && c <= 9
        }
        for i in 0...18 {
            let id = Int(paperId[i])
            if isDigit(c: id) && !(88 == id || 120 == id) && 17 == i {
                return false
            }
        }
        //验证最末的校验码
        for i in 0...16 {
            let v = Int(paperId[i])
            lSumQT += (v - 48) * R[i]
        }
        if sChecker[lSumQT%11] != paperId[17] {
            return false
        }
        return true
    }
    func areaCodeAt(_ code: String) -> Bool {
        var dic: [String: String] = [:]
        dic["11"] = "北京"
        dic["12"] = "天津"
        dic["13"] = "河北"
        dic["14"] = "山西"
        dic["15"] = "内蒙古"
        dic["21"] = "辽宁"
        dic["22"] = "吉林"
        dic["23"] = "黑龙江"
        dic["31"] = "上海"
        dic["32"] = "江苏"
        dic["33"] = "浙江"
        dic["34"] = "安徽"
        dic["35"] = "福建"
        dic["36"] = "江西"
        dic["37"] = "山东"
        dic["41"] = "河南"
        dic["42"] = "湖北"
        dic["43"] = "湖南"
        dic["44"] = "广东"
        dic["45"] = "广西"
        dic["46"] = "海南"
        dic["50"] = "重庆"
        dic["51"] = "四川"
        dic["52"] = "贵州"
        dic["53"] = "云南"
        dic["54"] = "西藏"
        dic["61"] = "陕西"
        dic["62"] = "甘肃"
        dic["63"] = "青海"
        dic["64"] = "宁夏"
        dic["65"] = "新疆"
        dic["71"] = "台湾"
        dic["81"] = "香港"
        dic["82"] = "澳门"
        dic["91"] = "国外"
        if (dic[code] == nil) {
            return false;
        }
        return true;
    }
    
}


//邮箱网址手机号码等正则判断
enum Validate {
    case email(_: String)
    case phoneNum(_: String)
    case carNum(_: String)
    case username(_: String)
    case password(_: String)
    case nickname(_: String)
    case telPhone(_: String)
    case telPhoneMustCros(_: String)
    case customTelPhone(_: String)
    case URL(_: String)
    case IP(_: String)
    
    var isRight: Bool {
        var predicateStr:String!
        var currObject:String!
        switch self {
        case let .email(str):
            predicateStr = "^([A-Za-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
        case let .phoneNum(str):
            predicateStr = "^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(14[0-9])|(16[0-9])|(19[0-9]))\\d{8}$"
            currObject = str
        case let .carNum(str):
            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
            currObject = str
        case let .username(str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currObject = str
        case let .password(str):
            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
            currObject = str
        case let .nickname(str):
            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
            currObject = str
        case let .telPhone(str):
            predicateStr = "^(0\\d{2,3}-?\\d{7,8}$)"
            currObject = str
        case let .telPhoneMustCros(str):
            predicateStr = "^(0\\d{2,3}-\\d{7,8}$)"
            currObject = str
        case let .customTelPhone(str):
            predicateStr = "^(1\\d{10})$|^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$"
            currObject = str
        case let .URL(str):
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            currObject = str
        case let .IP(str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currObject = str
        }
        
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
    var isTelPhone: Bool {
        switch self {
        case let .telPhone(str):
            //带-的电话号码
            let predicateStr = "^(0\\d{2,3}-?\\d{7,8}$)"
            let predicate = NSPredicate(format: "SELF MATCHES %@", predicateStr)
            let isPhone = predicate.evaluate(with: str)
            //不带-的电话号码
            let predicateStr1 = "^(\\d{7,8}$)"
            let predicate1 = NSPredicate(format: "SELF MATCHES %@", predicateStr1)
            let isPhone1 = predicate1.evaluate(with: str)
            return isPhone || isPhone1
        default:
            return false
        }
        
    }
}


extension String {
    
    var utf8Encoded: Data {
        
        return data(using: .utf8)!
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    //判断输入的字符串是不是数字
    func isPurnInt() ->Bool {
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        let result = scan.scanInt(&val) && scan.isAtEnd
        if result == true {
            print("数字\(self)")
        } else {
            print("非数字\(self)")
        }
        return result
    }
    // 本地化
    var lc: String {
        return NSLocalizedString(self, comment: "")
    }
}


extension String {

    // MARK: - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
    func getFirstLetterFromString(aString: String) -> (String) {
        
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: aString)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = polyphoneStringHandle(nameString: aString, pinyinString: pinyinString).uppercased()
        // 截取大写首字母
        let firstString = strPinYin.substring(to: strPinYin.index(strPinYin.startIndex, offsetBy:1))
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    /// 多音字处理
    func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }

    //6-20位以数字、字母或符号至少两种组合的密码
    func evalidateWithString(text: String,minLenght: Int=6,maxLenght: Int=20) -> Bool {
        
        let str = text
        let regex = "((?=.*\\d)(?=.*\\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))(?!^.*[\\u4E00-\\u9FA5].*$)^\\S{\(minLenght),\(maxLenght)}$"
//        let regex = "^(?:(?=.*[0-9].*)(?=.*[A-Za-z].*)(?=.*[\\W].*))[\\W0-9A-Za-z]{\(minLenght),\(maxLenght)}$"
//        let regex = "^(?![A-Za-z0-9]+$)(?![a-z0-9\\W]+$)(?![A-Za-z\\W]+$)(?![A-Z0-9\\W]+$)[a-zA-Z0-9\\W]{\(minLenght),\(maxLenght)}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: str)
        print(isValid)
        return isValid
    }

    //获取图片链接
    func getImgScrStr(img: String) -> Array<String> {

        /// 图片链接
        let image = img
        /// 正则规则字符串
        let pattern = "src\\s*=\\s*\"?(.*?)(\"|>|\\s+)"
        /// 正则规则
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        /// 进行正则匹配
        var imagesArray = [String]()
        if let results = regex?.matches(in: image, options: [], range: NSRange(location: 0, length: image.count)), results.count != 0 {
            print("匹配成功")
            for result in results{
                let string = (image as NSString).substring(with: result.range)
                let left = "\""
                let leftRange = (string as NSString).range(of: left)
                let src = (string as NSString).substring(with: NSMakeRange(leftRange.location + 1, string.count - leftRange.location - 2))
                print("对应:",src)
                imagesArray.append(src)
            }
        } else {
            print("filure")
        }
        return imagesArray
    }
    
 
}

