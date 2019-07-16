//
//  TabBar.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/16/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UIViewController
{
    var buttonContainer = UIView()
    var learnButton = tabBarButton()
    var savedButton = tabBarButton()
    var lbButton = tabBarButton()
    var settingsButton = tabBarButton()
    var viewControllers = ["Home","Liked","Leaderboard","Settings"]
    var prevButton: tabBarButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tab Bar was loaded")
        buttonContainer.frame = CGRect(x: 0, y: self.view.bounds.height - 50, width: self.view.bounds.width, height: 50)
        
        //Middle Buttons
        savedButton.frame = CGRect(x: (self.view.bounds.width / 2) - 50, y: 0, width: 35, height: 35)
        lbButton.frame = CGRect(x: (self.view.bounds.width / 2) + 50, y: 0, width: 35, height: 35)
        savedButton.setImage(#imageLiteral(resourceName: "icons8-heart-50 (1)"), for: .normal)
        savedButton.tag = 1
        savedButton.tntColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        savedButton.maskColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        savedButton.maskImage = #imageLiteral(resourceName: "icons8-heart-50 (2)")
        savedButton.title = "Likes"
        savedButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        lbButton.setImage(#imageLiteral(resourceName: "icons8-account-50"), for: .normal)
        lbButton.tag = 2
        lbButton.tntColor = #colorLiteral(red: 0.768171608, green: 0.8862745166, blue: 0.6753764657, alpha: 1)
        lbButton.maskColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        lbButton.maskImage = #imageLiteral(resourceName: "icons8-account-50 (1)")
        lbButton.title = "Leaderboard"
        lbButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        //Side Buttons
         learnButton.frame = CGRect(x: (self.view.bounds.width / 2) - 150, y: 0, width: 35, height: 35)
        settingsButton.frame = CGRect(x: (self.view.bounds.width / 2) + 150, y: 0, width: 35, height: 35)
        learnButton.setImage(#imageLiteral(resourceName: "icons8-home-50"), for: .normal)
        learnButton.tag = 0
        learnButton.tntColor = #colorLiteral(red: 0.5931200493, green: 0.8716481825, blue: 0.9764705896, alpha: 1)
        learnButton.maskColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        learnButton.maskImage = #imageLiteral(resourceName: "icons8-home-50 (1)")
        learnButton.title = "Learn"
        learnButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "icons8-settings-50 (2)"), for: .normal)
        settingsButton.tag = 3
        settingsButton.tntColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        settingsButton.maskColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        settingsButton.maskImage = #imageLiteral(resourceName: "icons8-settings-50 (3)")
        settingsButton.title = "Settings"
        settingsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        self.buttonContainer.addViews(views: [savedButton,lbButton,learnButton,settingsButton])
        self.view.addSubview(buttonContainer)
    }
    
    @objc func buttonPressed(_ sender: tabBarButton)
    {
        if let b = prevButton
        {
            b.stopAnimation()
        }
        print(viewControllers[sender.tag])
        sender.beginAnimation()
        prevButton = sender
    }
}



class tabBarButton: UIButton
{
    var title = String()
    var tntColor = UIColor()
    var maskColor = UIColor()
    var maskImage = UIImage()
    var oldImage = UIImage()
    var label = UILabel()
    var view = UIView()
    
    
    func beginAnimation()
    {
        view.frame = CGRect(x: -5, y: -7.5, width: 0, height: self.frame.height + 15)
        self.addSubview(self.view)
        self.sendSubviewToBack(self.view)
        view.layer.cornerRadius = 10
        view.backgroundColor = tntColor
        label.text = title
        label.frame = CGRect(x: 35, y: self.frame.minY, width: 85, height: 35)
        label.font = UIFont(name: "AvenirNext-Bold", size: 15.0)
        label.textColor = maskColor
        label.adjustsFontSizeToFitWidth = true
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.frame = CGRect(x: -5, y: -7.5, width: 125, height: self.frame.height + 15)
            self.oldImage = ((self.imageView?.image!)!)
            self.setImage(self.maskImage.mask(with: self.maskColor), for: .normal)
            self.frame = CGRect(x: self.frame.minX - 50, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
            
        }, completion: { (finished: Bool) in
            self.addSubview(self.label)
        })
    }
    
    func stopAnimation()
    {
         UIView.animate(withDuration: 0.2, animations: {
            self.frame = CGRect(x: self.frame.minX + 50, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
            self.view.frame = CGRect(x: -5, y: -7.5, width: 0, height: self.frame.height + 15)
            self.label.removeFromSuperview()
         }, completion: { (finished: Bool) in
            self.setImage(self.oldImage, for: .normal)
            self.view.removeFromSuperview()
        })
    }
}
