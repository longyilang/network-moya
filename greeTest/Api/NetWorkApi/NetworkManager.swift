//
//  NetworkManager.swift
//  greeTest
//
//  Created by mac on 2021/10/18.
//

import Foundation
import Moya

let GreeManager = Networking<GreeAPIManager>()

enum GreeAPIManager {
    //测试1
    case getWeather(area:String, areaID:String)
    //测试2
    case testHelpCenter
}

extension GreeAPIManager : MyServerType {
    
    //域名
    var baseURL: URL {
//        return URL(string: "https://api.apishop.net/")!
//        return URL(string: testURL)!
        switch self {
        case .getWeather:
            return URL(string: "https://api.apishop.net/")!
        case .testHelpCenter:
            return URL(string: testURL)!
        }
    }
    
    //接口路径
    public var path: String {
        switch self {
        case .getWeather:
            return "common/weather/get15DaysWeatherByArea"
        case .testHelpCenter:
            return "eoc/help_center/one_page_list"
        }
    }
    
    //请求类型：get、post、delete、put
    var method: HTTPMethod {
        switch self {
        case .getWeather(area: _ , areaID: _):
            return .post
        case .testHelpCenter:
            return .post
        }
//        return .post
    }
    
    //请求任务:
    public var task: Task {
        switch self {
        case .getWeather(let area, let areaID):
            let params = ["apiKey": "4AeS1xR898d08f1d5db57b5312b8c8b7ea57175f4a6941f",
                          "area": area,
                          "areaID": areaID] as [String : Any]
            return .requestParameters(parameters: params, encoding:URLEncoding.default)
        case .testHelpCenter:
            return .requestPlain
        }
            
    }
    
    //请求头
    var headers: [String : String]? {
        return [:]
    }
    
}

