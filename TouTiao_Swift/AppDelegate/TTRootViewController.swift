//
//  TTRootViewController.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTRootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let homeNav = UINavigationController(rootViewController: TTHomeViewController())
        homeNav.tabBarItem.title = "首页";
        
        let waterlemonNav = UINavigationController(rootViewController: TTWatermelonVideoViewController())
        waterlemonNav.tabBarItem.title = "西瓜视频";
        
        let findNav = UINavigationController(rootViewController: TTFindViewController())
        findNav.tabBarItem.title = "找人";
        
        let shortNav = UINavigationController(rootViewController: TTShortVideoViewController())
        shortNav.tabBarItem.title = "小视频";
        
        self.viewControllers = [homeNav,waterlemonNav,findNav,shortNav];
    }
    


}
