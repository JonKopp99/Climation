//
//  ChartsVC.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/16/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class ChartsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        print("ChartsVC")
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        backImage.image = #imageLiteral(resourceName: "DSC100373704")
        backImage.alpha = 0.3
        let ga = getGradientBackground()
        self.view.addSubview(backImage)
        self.view.layer.insertSublayer(ga, at:0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func getGradientBackground() -> CAGradientLayer{
        let colorTop = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        return gradientLayer
        
    }
}
