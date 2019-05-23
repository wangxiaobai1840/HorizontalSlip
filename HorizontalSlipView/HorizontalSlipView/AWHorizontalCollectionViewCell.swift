//
//  AWHorizontalCollectionViewCell.swift
//  HorizontalSlipView
//
//  Created by wlx on 2019/5/20.
//  Copyright © 2019 wlx. All rights reserved.
//

import UIKit
let LabelHeight:CGFloat = 20
class AWHorizontalCollectionViewCell: UICollectionViewCell {
    
    fileprivate var titleLable:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        createUI()
    }
    
    fileprivate func createUI(){
        titleLable.font = UIFont.systemFont(ofSize: 14)
        titleLable.backgroundColor = UIColor.clear
        titleLable.layer.masksToBounds = true
        titleLable.layer.cornerRadius = LabelHeight/2
        titleLable.frame = CGRect(x: 0, y: 0, width: 100, height: LabelHeight)
        titleLable.textAlignment = .center
        addSubview(titleLable)
    }
    
    func bind(title:String,isSelected:Bool,isLast:Bool){
        let width = (title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: LabelHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil).size.width+10
        if !isLast {
            titleLable.frame = CGRect(x: self.frame.width-width-10, y: 0, width: width, height: LabelHeight)
        }else{
            titleLable.frame = CGRect(x: 0, y: 0, width: width, height: LabelHeight)
        }
        if isSelected {
            titleLable.textColor = UIColor.black
            titleLable.backgroundColor = UIColor.white
        }else{
            titleLable.textColor = UIColor.white
            titleLable.backgroundColor = UIColor.clear
        }
        titleLable.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
