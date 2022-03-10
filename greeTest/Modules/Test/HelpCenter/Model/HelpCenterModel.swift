//
//  HelpCenterModel.swift
//  greeTest
//
//  Created by Gree on 2021/10/20.
//

import UIKit
import HandyJSON

class HelpCenterModel: HandyJSON {

    /// 选项列表
    var categoryList: [HelpCenterTwoModel] = []
    /// 页面分类目录 10-关于格力 20-购物引导 30-支付方式 40-关于配送 50-关于售后 60-管理制度 70-资质证明 80-特色服务
    var category: Int?
    
    /// 组标题
    var groupTitle: String{
        get {
            if category == 10 {
                return "关于格力"
            } else if category == 20 {
                return "购物引导"
            } else if category == 30 {
                return "支付方式"
            } else if category == 40 {
                return "关于配送"
            } else if category == 50 {
                return "关于售后"
            } else if category == 60 {
                return "管理制度"
            } else if category == 70 {
                return "资质证明"
            } else if category == 80 {
                return "特色服务"
            } else {
                return "-"
            }
        }
    }
    required init() {}
}

class HelpCenterTwoModel: HandyJSON {
    /// 一级页面标题
    var pageTitleOne: String = ""
    /// 页面类型 10-文章 20-目录列表
    var pageType: Int?
    required init() {}
    
}
