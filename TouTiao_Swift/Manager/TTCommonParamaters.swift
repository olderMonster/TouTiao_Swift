//
//  TTCommonParamaters.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/27.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTCommonParamaters: NSObject {

    static let shared = TTCommonParamaters()
    
    // Make sure the class has only one instance
    // Should not init or copy outside
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    // Optional
    func reset() {
        // Reset all properties to default value
    }
    
    
    func paramaters() -> [String:Any] {
        var params:[String:Any] = [String:Any]()
        params["refer"] = "1"
        params["count"] = "20" //返回数量
        params["min_behot_time"] = "1491981025" //上次请求时间的时间戳
        params["last_refresh_sub_entrance_interval"] = "1491981165" //本次请求时间的时间戳
        params["loc_mode"] = ""
        
        params["loc_time"] = "" //本地时间
        params["latitude"] = ""  //经度
        params["longitude"] = "" //纬度
        params["city"] = ""      //当前城市
        params["tt_from"] = "pull"
        params["lac"] = "31176"
        params["cid"] = "123456789"
        params["cp"] = "5183e0f15e6a4q1"
        params["iid"] = "0123456789"  //某个唯一 id，长度为10
        params["device_id"] = "12345678952" //设备 id，长度为11
        params["ac"] = "wifi"
        params["aid"] = "13"
        params["app_name"] = "news_article"
        params["version_code"] = TTAPIManager.shared.version_code
        params["version_name"] = TTAPIManager.shared.version_name
        params["device_platform"] = TTAPIManager.shared.device_platform
        
        params["ab_version"] = ""
        params["ab_client"] = ""
        params["ab_group"] = ""
        params["ab_feature"] = ""
        params["abflag"] = "3"
        params["ssmix"] = "a"
        params["device_type"] = "XIAOMI"
        params["device_brand"] = "Google"
        params["language"] = "zh"
        params["os_api"] = TTAPIManager.shared.os_api
        params["os_version"] = TTAPIManager.shared.os_version
        params["openudid"] = "123456789d36d6z6"  //某个唯一 id，长度为16
        params["manifest_version_code"] = "607"
        params["resolution"] = "1080*1821"
        params["dpi"] = "440"
        params["update_version_code"] = "6075"
        params["_rticket"] = "123456789123"

        
        
        return params
    }
    
}
