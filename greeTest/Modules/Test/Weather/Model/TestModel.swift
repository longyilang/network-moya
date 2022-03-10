//
//  TestModel.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit
import HandyJSON

class TestModel: HandyJSON {
    
    
    var area: String?
    var areaCode: String?
    var areaid: String?
    var dayList: [TestTwoModel] = []
    
    required init() {}
    
}

class TestTwoModel: HandyJSON {
    
    var area: String?
    var areaCode: String?
    var areaid: String?
    var day_air_temperature: String?
    var day_weather: String?
    var day_weather_code: String?
    var day_weather_pic: String?
    var day_wind_direction: String?
    var day_wind_power: String?
    var daytime: String?
    var night_air_temperature: String?
    var night_weather: String?
    var night_weather_code: String?
    var night_weather_pic: String?
    var night_wind_direction: String?
    var night_wind_power: String?
    
    required init() {}
    
}

