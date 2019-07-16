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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let tempView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 0))
        tempView.backgroundColor = #colorLiteral(red: 0.768171608, green: 0.8862745166, blue: 0.6753764657, alpha: 1).withAlphaComponent(0.6)
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 0.2, animations: {
            tempView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: { (finished: Bool) in
            self.view.backgroundColor = #colorLiteral(red: 0.768171608, green: 0.8862745166, blue: 0.6753764657, alpha: 1).withAlphaComponent(0.6)
            tempView.removeFromSuperview()
        })
    }
}
