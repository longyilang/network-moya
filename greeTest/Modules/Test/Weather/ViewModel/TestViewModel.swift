//
//  TestViewModel.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit
import HandyJSON

class TestViewModel: NSObject {
    
    //天气测试
    static func requestWeatherData(area: String, areaID: String,callBack: @escaping (_ infoModel:TestModel) -> ()) {

        GreeManager.requestJson(.getWeather(area: area, areaID: areaID)) { (dic) in
            
            guard let json : [String : Any] = dic as? [String : Any] else {return}
            
            let respont : [String : Any] = json["result"] as! [String : Any]
            
            guard let model = TestModel.deserialize(from: respont) else { return }
            
            callBack(model)

        } failure: { (error) in
            print(error.errorDescription as Any)
        }
    }
    
    
}
