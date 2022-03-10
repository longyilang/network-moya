//
//  GMSBaseModel.swift
//  grmallseller
//
//  Created by jsjzx on 2019/8/23.
//  Copyright © 2019 com.gree. All rights reserved.
//

import UIKit
import HandyJSON


/// 2.0的模型
class BaseModel: HandyJSON {
    var result: Int?
    var message: String?
    required init() {}
}

class GMBaseModel: HandyJSON {

    var code: Int?
    var message: String?
    required init() {}
}

class GMVersionBaseModel: HandyJSON {

    var result: Int?   //状态码 0-成功
    var message: String?
    required init() {}
}

class GMVersionBasicsModel<D>: HandyJSON {
    /// 状态码 0-成功
    var result: Int?
    var message: String = ""
    var data: D?
    required init() {}
}

class GMBaseStatusModel: HandyJSON {
    var code: Int?
    var message: String?
    var result: Any?
    required init() {}
}

class GMBasePageModel: HandyJSON {
    var totalCount: Int? //总item数量
    var totalPage: Int? //总页数
    var nextPage: Int? //下一页数
    var page: Int? //当前页数
    var records: Array<Any>?
    required init() {}
}

class GMBaseImgVideoResultModel: HandyJSON {
    
    var code: Int?
    var message: String?
    var result: GMBaseObjReusltModel?
    required init() {}

}

class GMBaseObjReusltModel: HandyJSON {
    var url: String?
    required init() {}

}

