//
//  Server.swift
//  MoyaDemo
//
//  Created by 陈思欣 on 2019/5/8.
//  Copyright © 2019 chensx. All rights reserved.
//

import Foundation
import UIKit
import AdSupport
import Alamofire
import Moya

class WebService: NSObject {
    
    var rootUrl: String = testURL
    var headers: [String: String]? = defaultHeaders()
    var parameters: [String: Any]? = defaultParameters()
    var timeoutInterval: Double = 30.0
    //和服务器时间相差的时间戳:备注每次app恢复活跃状态需更新一次
    static var serviceTimeSpace: String?
    
    static let shared = WebService()
    override init() {}
    
    static func defaultHeaders() -> [String : String]? {
        var headers = ["Content-type": "application/json", "x-flag": "iOS"]
        
        print(headers)
        return headers
    }
    
    static func defaultParameters() -> [String : Any]? {
        return ["platform" : "ios",
            "version" : "1.2.3",
        ]
    }
    
    /**
     签名MD5处理
     */
    static func appendSign(paramterDic: Dictionary<String, String>, secrekey:String) -> String {
        var sign:String = ""
        var keys:Array = Array(paramterDic.keys)
        keys = keys.sorted()
        for key:String in keys {
            if key == "sign" {
                continue
            } else {
                let keyValue: String = String(format: "%@", paramterDic[key]!)
                sign.append(String(format: "%@%@", key, keyValue.EscapesValr))
            }
        }
        sign.append(secrekey)
        return sign.td.md5.uppercased()
    }
}

