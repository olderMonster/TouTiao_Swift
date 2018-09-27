//
//  TTHomeManager.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTTagManager: TTRequestManager,TTRequestDelegate,TTRequestManagerValidator {
    func methodName() -> String! {
        return "api/news/feed/v51/"
    }
    
    func requestType() -> RequestType {
        return .get
    }
    
    
    override init() {
        super.init()
        self.delegate = self
        self.validator = self
    }
    
    
    //MARK: TTRequestManagerValidator
    func isCorrectWithCallBackData(manager:TTRequestManager,data:Dictionary<String,Any>?) -> Bool{
        return true
    }
    func isCorrectWithParamsData(manager:TTRequestManager,params:Dictionary<String,Any>?) -> Bool{
        let tag = params?["category"]
        if tag == nil {
            return false
        }
        return true
    }
}
