//
//  TTArticleViewController.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/27.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTArticleViewController: UIViewController,TTRequestDataSource,TTRequestManagerCallBackDelegate , UITableViewDataSource{

    public var tag:TTTag?
    private var articlesArray:[[String:Any]] = [[String:Any]]()
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.articleTableView)
        
        self.tagManager.loadData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.articleTableView.frame = self.view.bounds
    }
    
    //MARK: TTRequestDataSource
    func paramsForApi(manager:TTRequestManager) -> Dictionary<String,Any>? {
        if self.tag == nil {
            return nil
        }
        return ["category":self.tag!.tagCode!]
    }
    
    //MARK: TTRequestManagerCallBackDelegate
    func managerCallAPIDidSuccess(manager:TTRequestManager) -> Void{
        print("data ===>> \(manager.data!)")
    }
    
    func managerCallAPIDidFailed(manager:TTRequestManager) -> Void{
        
    }
    
    
    //MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.articlesArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
        }
        return cell!
    }
    
    //MARK: getters and setters
    private lazy var articleTableView:UITableView = {
       let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.addSubview(self.refreshControl)
        return tableView
    }()
    
    private lazy var refreshControl:UIRefreshControl = {
       let control = UIRefreshControl()
        return control
    }()
    
    private lazy var tagManager:TTTagManager = {
        let manager = TTTagManager()
        manager.dataSource = self
        manager.callback = self
        return manager
    }()


}
