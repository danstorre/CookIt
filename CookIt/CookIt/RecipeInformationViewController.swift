//
//  RecipeInformationViewController.swift
//  CookIt
//
//  Created by Daniel Torres on 3/26/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import UIKit


enum SectionInformation: Int {
    case header = 0, metaData, ingredients, steps
}


class RecipeInformationViewController: UIViewController {

    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var recipe : Recipe? = nil
    var instructions : [String]? = nil

    var metaDataVariables : [String:AnyObject] = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchRecipeInformation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RecipeInformationViewController {

    func searchRecipeInformation(){
        
        activity.startAnimating()
        tableView.isHidden = true
        
        CookItAPI.shared.getRecipe(by: String(recipe!.id!)) { (recipe, error) in
            performUIUpdatesOnMain {
                
                func sendError(){
                    let alertViewController = UIAlertController(title: "Alert!", message: "Sorry try again later", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigationController!.popToViewController((self.navigationController!.viewControllers.first)!, animated: true)
                    })
                    alertViewController.addAction(okButton)
                    
                    return self.present(alertViewController, animated: true, completion: nil)
                }
                
                guard error == nil else {
                    return sendError()
                }
                
                guard let recipe = recipe else {
                    return sendError()
                }
                
                self.recipe = recipe
                
                self.configureMetaData(with: recipe)
                
                
                self.activity.stopAnimating()
                self.tableView.isHidden = false
                
                self.tableView.reloadData()
            }
        }
    }
    
    func searchImages(){
        
    }
    
    func configureMetaData(with recipe: Recipe){
        
        metaDataVariables["vegetarian"] = recipe.vegetarian! as AnyObject
        metaDataVariables["glutenFree"] = recipe.glutenFree! as AnyObject
        metaDataVariables["cheap"] = recipe.cheap! as AnyObject
        metaDataVariables["sustainable"] = recipe.sustainable! as AnyObject
        metaDataVariables["servings"] = recipe.servings! as AnyObject
        
    }
    
}



extension RecipeInformationViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        var numberOrRowsToReturn = 0
        let sectionInfo = SectionInformation.init(rawValue: section)!
        
        switch sectionInfo {
            case .header : numberOrRowsToReturn = 1
            case .metaData : numberOrRowsToReturn = 1
            case .ingredients : numberOrRowsToReturn = 1
            case .steps : numberOrRowsToReturn = 1
            
        }
        return numberOrRowsToReturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionInfo = SectionInformation.init(rawValue: indexPath.section)!
        
        guard let recipe = recipe else {
            return UITableViewCell()
        }
        
        switch sectionInfo {
            
        case .header :
            let cellHeader = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderInformationTableViewCell
            
            if let image = recipe.image {
                cellHeader.imageRecipe.image = image
            }
            
            cellHeader.nameLabel.text = recipe.title
            
            return cellHeader
            
        case .metaData :
            let cellMetaInfoRecipe = tableView.dequeueReusableCell(withIdentifier: "meta") as! CollectionRowRecipeTableViewCell
            
            cellMetaInfoRecipe.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            
            return cellMetaInfoRecipe
            
        case .ingredients :
            let cellIngredients = tableView.dequeueReusableCell(withIdentifier: "ingredients") as! CollectionRowRecipeTableViewCell
            
            cellIngredients.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            
            return cellIngredients
            
        case .steps :
            let cellInstructions = tableView.dequeueReusableCell(withIdentifier: "instruction") as! InstructionTableViewCell
            
            guard let instructions = recipe.instructions else{
                return cellInstructions
            }
            cellInstructions.stepLabel.text = instructions
            
            return cellInstructions
        }
        
    }
    
    func tableView(tableView: UITableView,
                            willDisplayCell cell: UITableViewCell,
                            forRowAtIndexPath indexPath: NSIndexPath) {
        
        let sectionInfo = SectionInformation.init(rawValue: indexPath.section)!
        
        switch sectionInfo {
            
        case .header :
            guard let _ = cell as? HeaderInformationTableViewCell else {return}
            
        case .metaData :
            guard let cellMetaInfoRecipe = cell as? CollectionRowRecipeTableViewCell else {return}
            
            cellMetaInfoRecipe.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            
            
        case .ingredients :
            
            guard let cellIngredients = cell as? CollectionRowRecipeTableViewCell else {return}
            
            cellIngredients.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            
        case .steps :
            guard let _ = cell as? InstructionTableViewCell else {return}
        }
    }
    
    
}


extension RecipeInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
            
            case 1 : return metaDataVariables.count
            case 2 :
                guard let ingredients = recipe?.ingredients else {
                    return 0
                }
                return ingredients.count
            default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MetaCollectionViewCell{
            
            for (index,dictRow) in metaDataVariables.enumerated(){
                
                guard index == indexPath.row else {
                    continue
                }
                
                cell.variable.text = dictRow.key
                
                if let boolValue = dictRow.value as? Bool{
                    cell.checkImage.isHidden = boolValue
                }
                
                if let stringValue = dictRow.value as? String{
                    cell.value.text = stringValue
                }
                
            }
            
            return cell
        }
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? IngredientCollectionViewCell
        {
            
            guard let recipe = recipe else {
                return cell
            }
            
            cell.nameLabel.text = recipe.ingredients![indexPath.item].name
            cell.quantityLabel.text = String(describing: recipe.ingredients![indexPath.item].amount) + recipe.ingredients![indexPath.item].unit!
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

