//
//  ViewController.swift
//  HorizontalSlipView
//
//  Created by wlx on 2019/5/20.
//  Copyright © 2019 wlx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let views = AWHorizontalSlipView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: LabelHeight))
        views.selectedIndexAction = { index in
            print("选择了第\(index)")
        }
        self.view.addSubview(views)
        // Do any additional setup after loading the view.
    }


}

