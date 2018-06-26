//
//  SignInViewController.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/06/26.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    //背景色の変更
        let topColor = UIColor(red: 42/255, green:245/255, blue: 152/255, alpha:1)
        let bottomColor = UIColor(red:8/255, green:174/255, blue:234/255, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }


}
