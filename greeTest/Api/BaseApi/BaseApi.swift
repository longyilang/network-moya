//
//  BaseApi.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import Foundation

/// API请求完整路径
#if DEBUG
/// 环境域名切换
//测试API
let mainHost = testMainURL
#endif


/**
 测试环境
 */
//测试主Api
let testMainURL = "https://testingmall.gree.com/"



let testURL = mainHost + "mallv2/"

