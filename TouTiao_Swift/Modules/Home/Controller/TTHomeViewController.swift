//
//  TTHomeViewController.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit
import Alamofire
class TTHomeViewController: UIViewController {

    private var articleVCArray:[TTArticleViewController] = [TTArticleViewController]()
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.segementControl)
        self.view.addSubview(self.tagsScrollView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "标签", style: UIBarButtonItem.Style.plain, target: self, action: #selector(chooseTag))
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.segementControl.frame = CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 30)
        self.tagsScrollView.frame = CGRect(x: 0, y: self.segementControl.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - self.segementControl.frame.maxY)
        
        for index in 0..<self.articleVCArray.count {
            let articleVC  = self.articleVCArray[index]
            articleVC.view.frame = CGRect(x: self.tagsScrollView.bounds.width * CGFloat(index), y: 0, width: self.tagsScrollView.bounds.width, height:  self.tagsScrollView.bounds.height)
        }
        self.tagsScrollView.contentSize = CGSize(width: self.tagsScrollView.bounds.width * CGFloat(self.articleVCArray.count), height: 0)
        
    }

    //MARK: event response
    @objc func chooseTag() -> Void {
        self.navigationController?.pushViewController(TTTagViewController(), animated: true)
    }
    
        
    
    //MARK: getters and setters
    private lazy var segementControl:TTSegementControl = {
       let segementControl = TTSegementControl()
        segementControl.tagsArray = self.tagsArray
        return segementControl
    }()
    
    private lazy var tagsScrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false
        
        articleVCArray = [TTArticleViewController]()
        for index in 0..<self.tagsArray.count {
            let artilceVC = TTArticleViewController()
            artilceVC.tag = self.tagsArray[index]
            scrollView.addSubview(artilceVC.view)
            articleVCArray.append(artilceVC)
        }
        return scrollView
    }()
    
    private lazy var tagsArray:[TTTag] = {
        let userTagsArray = UserDefaults.standard.object(forKey: kUserDefaultTagsKey) as? [[String : Any]]
        if userTagsArray == nil {
            let plistPath = Bundle.main.path(forResource: "category", ofType: "plist")
            let allTagsArray:[[String:Any]] = NSArray(contentsOfFile: plistPath!) as! [[String : Any]]
            let tagModel = TTTag(dict: allTagsArray.first!)
            return [tagModel]
        }else {
            var tagsModelArray = [TTTag]()
            for dict in userTagsArray! {
                let tagModel = TTTag(dict: dict)
                tagsModelArray.append(tagModel)
            }
            return tagsModelArray
        }
    }()
    
    
    private var _page:NSInteger = 0
    private var page:NSInteger {
        get{
           _page = NSInteger(self.tagsScrollView.contentOffset.x/self.view.bounds.width)
           return _page
        }
        set{
            _page = newValue
        }
    }
    
}
