//
//  HelpCenterViewModel.swift
//  greeTest
//
//  Created by Gree on 2021/10/20.
//

import UIKit
import HandyJSON

class HelpCenterViewModel: NSObject {

    static func requestPageList(success:@escaping (_ models: [HelpCenterModel])->()) {
        
        GreeManager.requestModel(.testHelpCenter) { (models:[HelpCenterModel], message) in
            success(models)
        } mistake: { result, message in
            print(message)
        } failure: { networkError in
            print("网络错误")
        }

        
    }
    
}
