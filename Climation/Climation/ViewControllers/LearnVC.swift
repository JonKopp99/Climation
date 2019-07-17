//
//  ViewController.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/16/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class LearnVC: UIViewController {
   // var tabBar = TabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.addChild(tabBar)
//        self.view.addSubview(tabBar.view)
        print("LearnVC")
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        let tempView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height))
        let ga = self.getGradientBackground()
        tempView.layer.insertSublayer(ga, at:0)
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 0.0, animations: {
            tempView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
             }, completion: { (finished: Bool) in
                tempView.removeFromSuperview()
                self.view.layer.insertSublayer(ga, at:0)
        })
    }

    func getGradientBackground()->CAGradientLayer{
        let colorTop = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        return gradientLayer
        
    }
}

