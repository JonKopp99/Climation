//
//  EmptyCell.swift
//  Climation
//
//  Created by Jonathan Kopp on 9/4/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
//
//  HomeCell.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/17/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//



import UIKit
import Foundation
class EmptyCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
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
    }
    
    
    
}

