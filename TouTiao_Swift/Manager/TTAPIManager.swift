//
//  TTAPIManager.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit
import Alamofire

enum TTAPIType {
    case development  //开发
    case test         //测试
    case distribution   //生产
}

class TTAPIManager: NSObject {
    
    static let shared = TTAPIManager()
    
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
    
    
    
    //MARK: getters and setters
    lazy var type:TTAPIType = {
       return .development
    }()
    
    lazy var baseURL:String = {
        if self.type == .development {
            return "http://is.snssdk.com"
        }else if self.type == .test {
            return "http://is.snssdk.com"
        }else{
            return "http://is.snssdk.com"
        }
    }()
    
    lazy var version_code:String = {
        if self.version_name.contains(".") {
            return self.version_name.replacingOccurrences(of:".", with:"")
        }
        return self.version_name
    }()
    
    lazy var version_name:String = {
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return currentVersion
    }()
    
    
    let tt_from:String = "pull"
    let device_platform:String = "device_platform"
    let language:String = "zh"
    let os_api:String = "23"
    lazy var os_version:String = {
        return UIDevice.current.systemVersion
    }()
    
}
