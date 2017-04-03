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
    
    
    var recipeSelected : Recipe? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFetchedResultsController()
        executeSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //MARK :- NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! RecipeInformationViewController
        
        vc.recipe = recipeSelected
        
    }

}

extension MyRecipesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let dbRecipe = fetchedResultsController?.object(at: indexPath) as? DBRecipe
        {
            recipeSelected = Recipe.toRecipe(from: dbRecipe)
            self.performSegue(withIdentifier: "recipeInfo", sender: self)
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
