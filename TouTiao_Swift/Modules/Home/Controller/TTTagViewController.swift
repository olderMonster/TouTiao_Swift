//
//  TTTagViewController.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

let kUserDefaultTagsKey = "kUserDefaultTagsKey"

class TTTagViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tagCollectionView)
        
        self.loadData()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tagCollectionView.frame = self.view.bounds
    }
    
    
    //MARK: http request
    func loadData() -> Void {
        
        var userTagsArray = UserDefaults.standard.object(forKey: kUserDefaultTagsKey)
        let plistPath = Bundle.main.path(forResource: "category", ofType: "plist")
        var allTagsArray:[[String:Any]] = NSArray(contentsOfFile: plistPath!) as! [[String : Any]]
        if userTagsArray == nil {
            userTagsArray = [[String:Any]]()
        }else{
            var otherTagsArray:[[String:Any]] = [[String:Any]]()
            for allTag in allTagsArray {
                for userTag in (userTagsArray! as! [[String:Any]]) {
                    let allTagTitle = allTag["title"] as! String
                    let userTagTitle = userTag["title"] as! String
                    if allTagTitle != userTagTitle {
                        otherTagsArray.append(allTag)
                    }
                }
            }
            allTagsArray = otherTagsArray
        }
        self.tagsArray = [userTagsArray,allTagsArray]  as! [NSArray]
        self.tagCollectionView.reloadData()
        
    }
    
    
    //MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return self.tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        let array:NSArray = self.tagsArray[section]
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! TTTagsCell
        let dict = self.tagsArray[indexPath.section][indexPath.row] as! NSDictionary
        cell.tagText = (dict["title"] as! String)
        cell.type = indexPath.section == 0 ? TTTagsCellType.user : TTTagsCellType.all
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        var headerView = TTTagsSectionHeaderView()
        if kind == UICollectionView.elementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier", for: indexPath) as! TTTagsSectionHeaderView
            if indexPath.section == 0 {
                headerView.title = "我的频道"
                headerView.desc = "点击进入频道"
                headerView.showEdit = true
            }else{
                headerView.title = "所有频道"
                headerView.desc = "点击添加频道"
                headerView.showEdit = false
            }
        }
        return headerView
    }
    
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cols = 4;
        let contentW:CGFloat = collectionView.bounds.width  - collectionView.contentInset.left - collectionView.contentInset.right
        let itemW = (contentW - 10 * CGFloat(cols - 1))/CGFloat(cols)
        return CGSize(width: itemW, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: collectionView.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //添加tag到“我的频道”
        if indexPath.section == 1 {
            
            var userTagsArray:Array = self.tagsArray.first! as Array
            var otherTagsArray:Array = self.tagsArray.last! as Array
            
            let tag = self.tagsArray[indexPath.section][indexPath.row] as! NSDictionary
            userTagsArray.append(tag)
            otherTagsArray.remove(at: indexPath.row)
    
            self.tagsArray = [userTagsArray,otherTagsArray] as [NSArray]
            
            collectionView.reloadData()
        }
        
        //进入频道或者从“我的频道”移除
        if indexPath.section == 0 {
            
        }
        
        
    }
    
    
    //MARK: getters and setters
    lazy var tagCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        let edgeInset:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = edgeInset
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TTTagsCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView.register(TTTagsSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier")
        return collectionView;
    }()
    
    var tagsArray:[NSArray] = [NSArray]()
}
