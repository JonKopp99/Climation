//
//  CustomClasses.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/18/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class NavBarHeaderView: UIViewController
{
    var headertitle = String()
    var color: UIColor?
    var txtColor: UIColor?
    var btnMask: UIColor?
    var shadow: Bool?
    var buttonDisabled: Bool?
    
    override func viewDidLoad() {
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.1))
        navView.backgroundColor = .clear
        navView.isOpaque = true
        
        let label = UILabel(frame: CGRect(x:0, y: navView.bounds.height/2-10, width: navView.bounds.width, height: 50))
        label.text = headertitle
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if let tc = txtColor{
            label.textColor = tc
        }
        label.font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 30.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        if let _ = shadow
        {
            label.shadowColor = .black
            label.shadowOffset = CGSize(width: -2, height: 2)
        }
        
        navView.addSubview(label)
        
        let backbutton = UIButton(frame: CGRect(x: 10, y: label.frame.minY + 12.5, width: 25, height: 25))
        backbutton.setImage(#imageLiteral(resourceName: "icons8-chevron-left-50"), for: .normal)
        if let bc = btnMask{
            backbutton.setImage(#imageLiteral(resourceName: "icons8-chevron-left-50").mask(with: bc), for: .normal)
        }
        navView.addSubview(backbutton)
        backbutton.addTarget(self, action:#selector(self.backPressed), for: .touchUpInside)
        if let buttonState = buttonDisabled
        {
            if(buttonState){backbutton.removeFromSuperview()}
        }
        self.view.addSubview(navView)
    }

    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
