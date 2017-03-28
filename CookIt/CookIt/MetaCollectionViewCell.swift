//
//  MetaCollectionViewCell.swift
//  CookIt
//
//  Created by Daniel Torres on 3/26/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import UIKit

class MetaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var variable: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var uncheckedImage: UIImageView!
    
    
    override var isSelected: Bool {
        
        didSet{
            checkImage.isHidden = false
        }
        
    }
}
