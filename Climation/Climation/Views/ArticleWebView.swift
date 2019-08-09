//
//  ArticleWebView.swift
//  Climation
//
//  Created by Jonathan Kopp on 8/6/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ArticleWebView: UIView
{
    
    var webView = WKWebView()
    var url = String()
    var top = CGFloat()
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        let b = UIButton()
        b.frame = CGRect(x: 15, y: top + 2.5, width: 15, height: 15)
        b.setImage(#imageLiteral(resourceName: "icons8-x-50").mask(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: .normal)
        b.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        addSubview(b)
    }
    func loadView()
    {
        let theURL = URL(string: url)!
        webView.load(URLRequest(url: theURL))
        addSubview(webView)
        webView.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.webView.frame = CGRect(x: 0, y: self.top + 25, width: self.bounds.width, height: self.bounds.height - (self.top + 25))
            })
    }
    @objc func dismissView()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 0)
        }, completion: { (finished: Bool) in
            self.removeFromSuperview()
        })
        
    }
}
