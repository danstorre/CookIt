//
//  RecipeTableViewCell.swift
//  CookIt
//
//  Created by Daniel Torres on 3/25/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewRecipe: UIImageView!
    @IBOutlet weak var nameRecipe: UILabel!
    @IBOutlet weak var descriptionRecipe: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
