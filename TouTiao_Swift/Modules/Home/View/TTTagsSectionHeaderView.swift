//
//  TTTagsHeaderView.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTTagsSectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.descLabel)
        self.addSubview(self.editButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.editButton.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.editButton.center = CGPoint(x: self.bounds.width - self.editButton.bounds.width * 0.5, y: self.bounds.height * 0.5 - self.editButton.bounds.height * 0.5)
        self.editButton.layer.cornerRadius = self.editButton.bounds.height * 0.5
        
        if self.titleLabel.text != nil {
            let titleString = self.titleLabel.text! as NSString
            let size = titleString.size(withAttributes: [NSAttributedString.Key.font:self.titleLabel.font])
            self.titleLabel.frame = CGRect(x: 0, y: self.bounds.height * 0.5 - size.height * 0.5, width: size.width, height: size.height)
            
            if self.descLabel.text != nil {
                let descString = self.descLabel.text! as NSString
                let descSize = descString.size(withAttributes: [NSAttributedString.Key.font:self.descLabel.font])
                self.descLabel.frame = CGRect(x: self.titleLabel.frame.maxX + 5, y: self.titleLabel.frame.maxY - descSize.height, width: descSize.width, height: descSize.height)
            }
        }
        
    }
    
    
    //MARK: getters and setters
    private lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var descLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var editButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("编辑", for: UIControl.State.normal)
        button.setTitle("完成", for: UIControl.State.selected)
        button.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.0
        button.isHidden = true
        return button
    }()
    
    private var  _title:String?
    var title:String? {
        get{
            return _title
        }
        set{
            _title = newValue
            self.titleLabel.text = _title
        }
    }
    
    private var  _desc:String?
    var desc:String? {
        get{
            return _desc
        }
        set{
            _desc = newValue
            self.descLabel.text = _desc
        }
    }
    
    private var _showEdit:Bool = false
    var showEdit:Bool {
        get{
            return _showEdit
        }
        set{
            _showEdit = newValue
            self.editButton.isHidden = !_showEdit
        }
    }
    
}
