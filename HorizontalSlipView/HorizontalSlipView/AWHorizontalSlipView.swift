//
//  AWHorizontalSlipView.swift
//  HorizontalSlipView
//
//  Created by wlx on 2019/5/20.
//  Copyright © 2019 wlx. All rights reserved.
//

import UIKit
let KScreenWidth:CGFloat = UIScreen.main.bounds.width
class AWHorizontalSlipView: UIView {
    fileprivate var collectionView:UICollectionView!
    lazy fileprivate var dataSource:Array<String> = [
        "第1个",
        "第2个",
        "第3个长的",
        "第4个很长很长的",
        "第5个",
        "第6个很长很长的",
        "第7个很长的",
    ]
    fileprivate var selectedIndex:Int = 0
    lazy fileprivate var cellWidth:Array<NSNumber> = {()->[NSNumber] in
        return [NSNumber]()
    }()
    var selectedIndexAction:((Int)->())!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        createUI()
    }
    fileprivate func createUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        self.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        collectionView.register(AWHorizontalCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "AWHorizontalCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension AWHorizontalSlipView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AWHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AWHorizontalCollectionViewCell", for: indexPath) as! AWHorizontalCollectionViewCell
        let title = dataSource[indexPath.row]
        if indexPath.row == dataSource.count-1{
            if selectedIndex == indexPath.row{
                cell.bind(title: title, isSelected: true, isLast: true)
            }else{
                cell.bind(title: title, isSelected: false, isLast: true)
                
            }
        }else{
            if selectedIndex == indexPath.row{
                cell.bind(title: title, isSelected: true, isLast: false)
            }else{
                cell.bind(title: title, isSelected: false, isLast: false)
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = dataSource[indexPath.row]
        let width = (title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 20), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil).size.width+20
        if indexPath.row == 0 || indexPath.row == dataSource.count-1{
            cellWidth.append(NSNumber(value: Float((width+collectionView.frame.size.width)/2)))
            return CGSize(width:(width+collectionView.frame.size.width)/2, height: 20)
        }
        cellWidth.append(NSNumber(value: Float(width)))
        return CGSize(width: width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        collectionView.scrollToItem(at:indexPath, at: .centeredHorizontally, animated: true)
        self.setImage(index: selectedIndex)
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        goToCell()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            goToCell()
        }
    }
    
    fileprivate func goToCell(){
        var totalWidth:CGFloat = 0.0
        for i in 0..<cellWidth.count {
            let width = cellWidth[i].floatValue
            totalWidth = totalWidth + CGFloat(width)
            if totalWidth >= collectionView.contentOffset.x + KScreenWidth/2 {
                selectedIndex = i
                collectionView.reloadData()
                collectionView.scrollToItem(at: IndexPath.init(row: Int(i), section: 0), at: .centeredHorizontally, animated: true)
                self.setImage(index: selectedIndex)
                return
            }
        }
        
    }
    
    fileprivate func setImage(index:Int){
        if selectedIndexAction != nil {
            selectedIndexAction!(index)
        }
    }
}
