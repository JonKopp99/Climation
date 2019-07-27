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
        
        createNavBar()
        let co2View = co2Chart()
        co2View.frame = CGRect(x: 0, y: view.bounds.height * 0.1, width: view.bounds.width, height: view.bounds.height * 0.4)
        self.view.addSubview(co2View)
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
    
    func createNavBar()
    {
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.1))
        navView.backgroundColor = .clear
        navView.isOpaque = true
        
        let label = UILabel(frame: CGRect(x:0, y: navView.bounds.height/2-10, width: navView.bounds.width, height: 50))
        label.text = "Charts"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 30.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: -2, height: 2)
        
        navView.addSubview(label)
        self.view.addSubview(navView)
    }
}
