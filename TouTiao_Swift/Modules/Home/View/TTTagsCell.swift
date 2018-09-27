//
//  TTTagsCell.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/26.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

enum TTTagsCellType {
    case user
    case all
}

class TTTagsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.borderView)
        self.contentView.addSubview(self.deleteButton)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.deleteButton.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        self.deleteButton.center = CGPoint(x: self.bounds.width - self.deleteButton.bounds.width * 0.5, y: self.deleteButton.bounds.height * 0.5)
        
        self.borderView.bounds = CGRect(x: 0, y: 0, width: self.contentView.bounds.width - self.deleteButton.bounds.width, height: self.contentView.bounds.height - self.deleteButton.bounds.height * 0.5)
        self.borderView.center = CGPoint(x: self.contentView.bounds.width * 0.5, y: self.contentView.bounds.height * 0.5)
        
        self.addImageView.frame = CGRect(x: 3, y: 3, width: self.borderView.bounds.height - 6, height: self.borderView.bounds.height - 6)
        if self.type == .user {
            self.tagLabel.frame = self.borderView.bounds
        }else{
            self.tagLabel.frame = CGRect(x: self.addImageView.frame.maxX, y: 0, width: self.borderView.bounds.width - self.addImageView.frame.maxX - self.addImageView.frame.minX, height: self.borderView.bounds.height)
        }


    }
    
    
    //MARK: getters and setters
    private lazy var borderView:UIView = {
       let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        
        view.addSubview(addImageView)
        view.addSubview(tagLabel)
        
        return view
    }()
    
    private lazy var addImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tag_add_btn"))
        return imageView
    }()
    
    private lazy var tagLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var deleteButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage(named: "tag_delete_btn"), for: UIControl.State.normal)
        return button
    }()

    
    private var  _tagText:String?
    var tagText:String? {
        get{
            return _tagText
        }
        set{
            _tagText = newValue
            self.tagLabel.text = tagText
        }
    }
    
    private var _type:TTTagsCellType = .user
    var type:TTTagsCellType {
        get{
            return _type
        }
        set{
            _type = newValue
            if _type == .user {
                self.addImageView.isHidden = true
                self.deleteButton.isHidden = false
                self.borderView.backgroundColor = UIColor.lightGray;
            }else{
                self.addImageView.isHidden = false
                self.deleteButton.isHidden = true
                self.borderView.backgroundColor = UIColor.white
            }
            self.setNeedsLayout()
        }
    }
    

    
}
