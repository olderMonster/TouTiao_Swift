//
//  TTSegementControl.swift
//  TouTiao_Swift
//
//  Created by 印聪 on 2018/9/27.
//  Copyright © 2018年 印聪. All rights reserved.
//

import UIKit

class TTSegementControl: UIView {

    var buttonsArray:[UIButton]?
    
    //MARK life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.contentScrollView)
        self.addSubview(self.bottomLineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentScrollView.frame = self.bounds
        self.bottomLineView.frame = CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
        
        if self.buttonsArray != nil {
            let buttonW:CGFloat = 80
            for index in 0..<self.buttonsArray!.count {
                let button = self.buttonsArray![index]
                button.frame = CGRect(x: buttonW * CGFloat(index), y: 0, width: buttonW, height: self.contentScrollView.bounds.size.height)
            }
        }
        
    }
    
    
    //MARK: getters and setters
    private lazy var contentScrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var bottomLineView:UIView = {
       let linewView = UIView()
        linewView.backgroundColor = UIColor.lightGray
        return linewView
    }()
    
    public var tagsArray:[TTTag]? {
        didSet{
            if self.buttonsArray != nil {
                for button in self.buttonsArray! {
                    button.removeFromSuperview()
                }
            }
            
            if self.tagsArray != nil {
                buttonsArray = [UIButton]()
                for index in 0..<self.tagsArray!.count {
                    let tagModel = self.tagsArray![index]
                    let button = UIButton(type: UIButton.ButtonType.custom)
                    button.setTitle(tagModel.title, for: UIControl.State.normal)
                    button.setTitleColor(UIColor.black, for: UIControl.State.normal)
                    button.setTitleColor(UIColor.red, for: UIControl.State.selected)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    self.contentScrollView.addSubview(button)
                    buttonsArray?.append(button)
                }
            }
            
            self.setNeedsLayout()
        }
    }
    
}
