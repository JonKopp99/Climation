//
//  LikesVC.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/16/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class LikesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("LikesVC")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let tempView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height))
        let ga = getGradientBackground()
        tempView.layer.insertSublayer(ga, at:0)
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 0.0, animations: {
            tempView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: { (finished: Bool) in
            tempView.removeFromSuperview()
            self.view.layer.insertSublayer(ga, at:0)
        })
    }
    func getGradientBackground()-> CAGradientLayer{
        let colorTop =  #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        return gradientLayer
        
    }
}
