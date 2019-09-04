//
//  HomeCell.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//



import UIKit
import Foundation
class HomeCell: UICollectionViewCell{
    
    var backImage = UIImageView()
    var nameLabel = UILabel()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 10
            frame.size.width -= 20
            frame.origin.x += 10
            super.frame = frame
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height / 4
        backgroundColor = .clear
        
        backImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        backImage.layer.cornerRadius = self.frame.height * 0.05
        backImage.layer.masksToBounds = true
        backImage.clipsToBounds = true
        backImage.contentMode = .scaleAspectFill
        backImage.alpha = 0.9
        addSubview(backImage)
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        //nameLabel.numberOfLines = nameLabel.text!.numberOfWords / 6
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 50.0)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.shadowColor = .black
        nameLabel.shadowOffset = CGSize(width: -2, height: 2)
        nameLabel.adjustsFontSizeToFitWidth = true
        addSubview(nameLabel)
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.backImage = UIImageView()
        self.nameLabel = UILabel()
    }
    
    
}

