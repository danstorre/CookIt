//
//  RecipesSearchTableViewController.swift
//  CookIt
//
//  Created by Daniel Torres on 3/25/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import UIKit

class RecipesSearchTableViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let titles = ["Search","Dishes","Recipes"]
    let descriptions = ["Please choose your cuisine type","Choose your dish type","Here you go, choose your favourite!"]
    
    var option : Int?
    var recipeSelected : Recipe?
    var items : [AnyObject]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        option = option ?? 0
        
        self.prepareItems()
        
        title = titles[option!]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! RecipeInformationViewController
        
        vc.recipe = recipeSelected
        
    }
    
}

private extension RecipesSearchTableViewController {
    
    func prepareItems(){
        
        var arrayToReturn = [String]()
        
        switch option! {
        case 0:
            for i in iterateEnum(ConstantsGeneral.Cuisine.self){
                guard i.rawValue != "" else {
                    continue
                }
                arrayToReturn.append(i.rawValue)
            }
            
        case 1:
            for i in iterateEnum(ConstantsGeneral.TypeDish.self){
                guard i.rawValue != "" else {
                    continue
                }
                arrayToReturn.append(i.rawValue)
            }
            
        case 2:
            addRecipesToTableView()
            
        default:
            break
        }
        arrayToReturn.sort { return $0 < $1 }
        self.items = (arrayToReturn as AnyObject) as? [AnyObject]
    
    }
    
    func addRecipesToTableView(){
    
        activity.startAnimating()
        tableView.isHidden = true
        let optionsSelectedForRecipe = (Settings.shared.cuisine!.rawValue, Settings.shared.type!.rawValue)
        
        CookItAPI.shared.getRecipes(by: optionsSelectedForRecipe, completionHandlerForGettingRecipes: { (recipes, error) in
            
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
                
                guard var recipes = recipes else {
                    return sendError()
                }
                
                recipes = recipes.sorted(by: {$0.0.title! < $0.1.title! })
                self.items = (recipes as AnyObject) as? [AnyObject]
                
                self.activity.stopAnimating()
                self.tableView.isHidden = false
                
                self.tableView.reloadData()
                
                DispatchQueue.global().async {
                    self.searchImages()
                }
            }
            
        })
    }
    
    
    func searchImages(){
        
        guard self.items != nil else {
            return
        }
        
        for (index,recipe) in self.items!.enumerated() {
            func imageToSearch(imageString: String, count: Int, index: Int){
                CookItAPI.shared.getImage(by: imageString, with: ConstantsGeneral.ImageSize.xxs, completionHandlerForGettingImage: { (image,error) in
                    
                    guard error == nil else {
                        return
                    }
                   
                    
                    var recipeFromIndex = self.items![index] as! Recipe
                    recipeFromIndex.image = image
                    self.items![index] = recipeFromIndex as AnyObject
                    
                    performUIUpdatesOnMain {
                        let indexPathToReload = IndexPath(row: index, section: 1)
                        self.tableView.reloadRows(at: [indexPathToReload], with: UITableViewRowAnimation.fade)
                    }
                    
                })
            }
            
            guard let imageString = (recipe as! Recipe).id else {
                continue
            }
            
            imageToSearch(imageString: String(imageString), count: 0, index: index)
            
        }
        
    }
    
}


extension RecipesSearchTableViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        var itemsCount = 0
        if let items = items {
            itemsCount = items.count
        }
        let numberOfRows = section == 0 ? 1 : itemsCount
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.section != 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! HeaderCellTableViewCell
            
            cell.titleLabel.text = titles[option!]
            cell.descriptionLabel.text = descriptions[option!]
            
            return cell
        }
        
        guard option! == 2 else {
            
            // if we are NOT in recipes table..
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            guard let items = items else {
                return cell
            }
            
            cell.textLabel!.text = (items[indexPath.row] as! String)
            
            return cell
        }
        
        // if we are in recipes table..
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath) as! RecipeTableViewCell
        
        guard let items = items else {
            return cell
        }
        
        let recipe = items[indexPath.row] as! Recipe
        
        cell.nameRecipe!.text = recipe.title
        cell.descriptionRecipe!.text = "ready in \(recipe.readyInMinutes!) min"
        
        if let image = recipe.image {
            cell.imageViewRecipe!.image = image
            cell.imageViewRecipe!.contentMode = UIViewContentMode.scaleAspectFit
            cell.imageViewRecipe!.clipsToBounds = true
        }
        
        return cell
        
    }
    
    
}


extension RecipesSearchTableViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        guard indexPath.section != 0 else {
            return 100
        }
        
        return option == 2 ? 60 : 44
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard option! < 2 else {
            
            guard let items = items else {
                return
            }
                   
            var recipeToTransfer = items[indexPath.row] as! Recipe
            recipeToTransfer.image = nil
            recipeSelected = recipeToTransfer
            performSegue(withIdentifier: "recipe", sender: nil)
            
            return
        }
        
        let optionSelected = self.option! + 1
        
        let itemSelected = items![indexPath.row]
        
        let tableViewController = self.storyboard!.instantiateViewController(withIdentifier: "RecipesSearchTableViewController") as! RecipesSearchTableViewController
        
        
        tableViewController.option = optionSelected
        
        switch option! {
        case 0:
            Settings.shared.cuisine = ConstantsGeneral.Cuisine(rawValue: itemSelected as! String)
            self.navigationController!.pushViewController(tableViewController, animated: true)
        case 1:
            Settings.shared.type = ConstantsGeneral.TypeDish(rawValue: itemSelected as! String)
            self.navigationController!.pushViewController(tableViewController, animated: true)
            
        default:
            break
        }
        
        
        // Push the new controller onto the stack
        
        
    }
}













