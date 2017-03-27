//
//  MetaInfoRecipeTableViewCell.swift
//  CookIt
//
//  Created by Daniel Torres on 3/26/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import UIKit

class CollectionRowRecipeTableViewCell: UITableViewCell {

    
    @IBOutlet fileprivate weak var informationCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


extension CollectionRowRecipeTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        informationCollectionView.delegate = dataSourceDelegate
        informationCollectionView.dataSource = dataSourceDelegate
        informationCollectionView.tag = row
        informationCollectionView.setContentOffset(informationCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        informationCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { informationCollectionView.contentOffset.x = newValue }
        get { return informationCollectionView.contentOffset.x }
    }
}









