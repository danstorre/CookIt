//
//  MyRecipesViewController.swift
//  CookIt
//
//  Created by Daniel Torres on 4/1/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyRecipesViewController: CoreDataCollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFetchedResultsController()
        executeSearch()
    }
    
    
    func configureFetchedResultsController(){
        
        // Get the stack
        let stack = CoreDataStack.shared
        
        // Create a fetchrequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "DBRecipe")
        fr.sortDescriptors = [NSSortDescriptor(key: DBRecipe.propertyNames.title, ascending: true)]
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
    }

}

extension MyRecipesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext,
            let dbRecipe = fetchedResultsController?.object(at: indexPath) as? DBRecipe
        {
            context.delete(dbRecipe)
        }
    }
}

extension MyRecipesViewController {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellRecipe", for: indexPath) as! MyRecipeCollectionViewCell
        
        guard fetchedResultsController != nil else {
            return cell
        }
        
        guard let dbRecipe = fetchedResultsController!.object(at: indexPath) as? DBRecipe else {
            return cell
        }
        // Create the cell
        
        cell.readyInMinutes.text = "Ready in \(dbRecipe.readyInMinutes)"
        cell.titleRecipe.text = dbRecipe.title!
        
        if let imageData = dbRecipe.image?.imageData, let image = UIImage(data: imageData as Data){
            cell.recipeImage.image = image
        }
        
        
        return cell
    }
    
}
