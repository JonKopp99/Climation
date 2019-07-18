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
    var viewControllerStrings = ["Home","Liked","Leaderboard","Settings"]
    var viewControllers = [LearnVC(), LikesVC(), ChartsVC(), SettingsVC()]
    var prevButton: tabBarButton?
    var prevVC: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tab Bar was loaded")
        let gapBehindContainer = UIView(frame: CGRect(x: 0, y: self.view.bounds.height - 20, width: self.view.bounds.width, height: 20))
        gapBehindContainer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //self.view.addSubview(gapBehindContainer)
        buttonContainer.frame = CGRect(x: 0, y: self.view.bounds.height - 50, width: self.view.bounds.width, height: 50)
        buttonContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.8)
        buttonContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonContainer.layer.cornerRadius = 20
        //Middle Buttons
        savedButton.frame = CGRect(x: (self.view.bounds.width / 2) - 47.5, y: 10, width: 30, height: 30)
        lbButton.frame = CGRect(x: (self.view.bounds.width / 2) + 22.5, y: 10, width: 30, height: 30)
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
        lbButton.maskColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        lbButton.maskImage = #imageLiteral(resourceName: "icons8-account-50 (1)")
        lbButton.title = "Charts"
        lbButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        //Side Buttons
         learnButton.frame = CGRect(x: (self.view.bounds.width / 2) - 117.5, y: 10, width: 30, height: 30)
        settingsButton.frame = CGRect(x: (self.view.bounds.width / 2) + 95, y: 10, width: 30, height: 30)
        learnButton.setImage(#imageLiteral(resourceName: "icons8-europe-50"), for: .normal)
        learnButton.tag = 0
        learnButton.tntColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        learnButton.maskColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        learnButton.maskImage = #imageLiteral(resourceName: "icons8-europe-50 (1)")
        learnButton.title = "Home"
        learnButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "icons8-settings-50 (2)"), for: .normal)
        settingsButton.tag = 3
        settingsButton.tntColor = #colorLiteral(red: 0.6656051117, green: 0.5, blue: 1, alpha: 1)
        settingsButton.maskColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        settingsButton.maskImage = #imageLiteral(resourceName: "icons8-settings-50 (3)")
        settingsButton.title = "Settings"
        settingsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        self.buttonContainer.addViews(views: [savedButton,lbButton,learnButton,settingsButton])
        self.view.addSubview(buttonContainer)
        buttonPressed(learnButton)
    }
    
    func notOnMainpage()
    {
        prevVC = nil
        if let prevB = prevButton
        {
            prevB.stopAnimation()
            
        }
    }
    @objc func buttonPressed(_ sender: tabBarButton)
    {
        if let b = prevButton
        {
            b.stopAnimation()
        }
        print(viewControllerStrings[sender.tag])
        sender.beginAnimation()
         let vc = viewControllers[sender.tag]
        if let previousVC = prevVC
        {
            vc.view.backgroundColor = sender.tntColor
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        addChild(vc)
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.view.addSubview(vc.view)
        self.view.sendSubviewToBack(vc.view)
        vc.view.bringSubviewToFront(self.view)
        vc.didMove(toParent: self)
        prevVC = viewControllers[sender.tag]
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
        view.layer.cornerRadius = view.bounds.height / 2
        view.backgroundColor = tntColor.withAlphaComponent(0.6)
        
        label.text = title
        label.frame = CGRect(x: 32, y: view.frame.minY + 7.5, width: 85, height: 35)
        label.font = UIFont(name: "Helvetica-Bold", size: 15.0)
        label.textColor = maskColor
        label.adjustsFontSizeToFitWidth = true
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.frame = CGRect(x: -5, y: -7.5, width: ((self.label.frame.width + self.frame.width) - 5 ), height: self.frame.height + 15)
            self.oldImage = ((self.imageView?.image!)!)
            self.setImage(self.maskImage.mask(with: self.maskColor), for: .normal)
            self.frame = CGRect(x: self.frame.minX - 35, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
            
        }, completion: { (finished: Bool) in
            self.addSubview(self.label)
        })
    }
    
    func stopAnimation()
    {
         UIView.animate(withDuration: 0.2, animations: {
            self.frame = CGRect(x: self.frame.minX + 35, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
            self.view.frame = CGRect(x: -5, y: -7.5, width: 0, height: self.frame.height + 15)
            self.label.removeFromSuperview()
         }, completion: { (finished: Bool) in
            self.setImage(self.oldImage, for: .normal)
            self.view.removeFromSuperview()
        })
    }
}
