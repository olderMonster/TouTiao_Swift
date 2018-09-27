//
//  TTTag.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTTag: NSObject {
    
    
    var title:String?
    var tagCode:String?
    
    override init() {
        super.init()
    }

    init(dict:[String:Any]){
        super.init()
        self.title = (dict["title"] as! String)
        self.tagCode = (dict["tag"] as! String)
    }
    
}
