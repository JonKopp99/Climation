//
//  TopicCell.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/18/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit
class TopicCell: UITableViewCell{
    
    var backImage = UIImageView()
    var nameLabel = UILabel()
    var timeLabel = UILabel()
    var type = String()
    var time = Int()
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 5
            frame.size.height -= 10
            frame.size.width -= 30
            frame.origin.x += 15
            super.frame = frame
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height / 4
        
        backgroundColor = .clear
        
        backImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        backImage.layer.cornerRadius = self.frame.height * 0.15
        backImage.layer.masksToBounds = true
        backImage.clipsToBounds = true
        backImage.contentMode = .scaleAspectFill
        backImage.alpha = 0.9
        addSubview(backImage)
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2)
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 40.0)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.shadowColor = .black
        nameLabel.shadowOffset = CGSize(width: -2, height: 2)
        nameLabel.adjustsFontSizeToFitWidth = true
        addSubview(nameLabel)
        
        timeLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        timeLabel.font = UIFont(name: "Helvetica-Light", size: 30.0)
        timeLabel.textAlignment = .center
        timeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        timeLabel.shadowColor = .black
        timeLabel.shadowOffset = CGSize(width: -2, height: 2)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.text = "\(time) min read"
        addSubview(timeLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

