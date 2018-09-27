//
//  TTRequestManager.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit
import Alamofire

enum RequestType {
    case get
    case post
}

enum RequestErrorType {
    case params   //参数错误
    case data     //返回数据错误
    case network  //网络错误
    case error    //请求错误
}

typealias requestHandler = (Dictionary<String, Any>?,Error?) -> ()

protocol TTRequestDelegate {
    func methodName() -> String!
    func requestType() -> RequestType
}

protocol TTRequestDataSource {
    func paramsForApi(manager:TTRequestManager) -> Dictionary<String,Any>?
}

protocol TTRequestManagerValidator {
    func isCorrectWithCallBackData(manager:TTRequestManager,data:Dictionary<String,Any>?) -> Bool
    func isCorrectWithParamsData(manager:TTRequestManager,params:Dictionary<String,Any>?) -> Bool
}

protocol TTRequestManagerCallBackDelegate {
    func managerCallAPIDidSuccess(manager:TTRequestManager) -> Void
    func managerCallAPIDidFailed(manager:TTRequestManager) -> Void
}

class TTRequestManager: NSObject {

    func loadData() -> Void {
        
        var apiParams:Dictionary<String,Any> = Dictionary<String,Any>()
        //接口参数
        if self.dataSource != nil {
            var params = self.dataSource!.paramsForApi(manager: self)
            if params != nil {
                for e in params! {
                    apiParams[e.key] = params![e.key]
                }
            }
        }
        
        //公共参数
        let commomParams = TTCommonParamaters.shared.paramaters()
        if commomParams.keys.count > 0 {
            for e in commomParams {
                apiParams[e.key] = commomParams[e.key]
            }
        }
        
        if self.validator != nil {
            let result = self.validator!.isCorrectWithParamsData(manager: self, params: apiParams)
            if result == false {
                self.errorType = RequestErrorType.params
                self.afterFailedInRequestAPI()
                return
            }
        }
        
        var urlString:String = TTAPIManager.shared.baseURL
        let methodName = self.delegate.methodName()
        if methodName == nil {
            if self.callback != nil {
                self.callback?.managerCallAPIDidFailed(manager: self)
            }
            return
        }
        urlString.append("/\(methodName!)")
        
        var type:HTTPMethod = HTTPMethod.get
        if self.delegate.requestType() == .post {
            type = HTTPMethod.post
        }
        
        //这边需要判断一下网络是否可用

        
        //发起网络请求
        Alamofire.request(urlString, method: type, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
//                debugPrint(response)

                // 有错误就打印错误，没有就解析数据
                if response.result.error != nil {
                    self.errorType = RequestErrorType.error
                    self.afterFailedInRequestAPI()
                }else{
                    let data = try? JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String,Any>
                    self.data = data
                    self.afterSucceedInRequestAPI()
                }

                
        }
    }
    
    
    //MARK: private method
    func afterSucceedInRequestAPI() -> Void {
        if self.validator != nil {
            let result = self.validator?.isCorrectWithCallBackData(manager: self, data: self.data)
            if result == true {
                if self.callback != nil {
                    self.callback?.managerCallAPIDidSuccess(manager: self)
                }
            }else {
                if self.callback != nil {
                    self.errorType = RequestErrorType.data
                    self.callback?.managerCallAPIDidFailed(manager: self)
                }
            }
        }else {
            if self.callback != nil {
                self.callback?.managerCallAPIDidSuccess(manager: self)
            }
        }
    }
    
    
    func afterFailedInRequestAPI() -> Void {
        if self.callback != nil {
            self.callback?.managerCallAPIDidFailed(manager: self)
        }
    }
    
    //MARK: getters and setters
    var delegate:TTRequestDelegate!
    var dataSource:TTRequestDataSource?
    var validator:TTRequestManagerValidator?
    var callback:TTRequestManagerCallBackDelegate?
    var data:Dictionary<String, Any>?
    var errorType:RequestErrorType?
}
