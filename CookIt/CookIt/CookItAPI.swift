//
//  ParseApiController.swift
//  OntheMap_DanielTorres
//
//  Created by Daniel Torres on 12/18/16.
//  Copyright © 2016 Daniel Torres. All rights reserved.
//

import UIKit


protocol CookItProtocol {
    
    func getRecipes(by options: (String,String),completionHandlerForGettingRecipes: @escaping (_ recipes: [Recipe]?, _ error: NSError?) -> Void)
    
    func getRecipe(by id: String, completionHandlerForGettingRecipe: @escaping (_ recipe: Recipe?, _ error: NSError?) -> Void)
    
    func getComplexRecipes(completionHandlerForGettingRecipes: @escaping (_ recipes: [Recipe]?, _ error: NSError?) -> Void)
    
    func getIngredient(by query: String, completionHandlerForGettingIngredient: @escaping (_ recipes: [Ingredient]?, _ error: NSError?) -> Void)
    
    func getImage(by imageID: String, with size: ConstantsGeneral.ImageSize, completionHandlerForGettingImage: @escaping (_ recipes: UIImage?, _ error: NSError?) -> Void)
    
}


class CookItAPI: CookItProtocol {
    
    static let shared = CookItAPI()
    
    let networkController = Network()
    
    init(){
        networkController.headers = [
            "Accept": "application/json",
            "X-Mashape-Key": Credentials.mashapeKey
        ]
        
        networkController.host = "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
        networkController.scheme = "https"
    }
    
    
    func getRecipes(by options: (String, String), completionHandlerForGettingRecipes: @escaping ([Recipe]?, NSError?) -> Void) {
        
        
        /* 1. Set the parameters */
        
        let parameters : [String:AnyObject] = [
            APIConstants.UrlKeys.cuisine : options.0 as AnyObject,
            APIConstants.UrlKeys.query : options.1 as AnyObject,
            APIConstants.UrlKeys.number : 20 as AnyObject
            ]
        
        
        /* 2. Build the URL & Configure the request*/
        
        var request = NSMutableURLRequest(url: networkController.parseURLFromParameters(parameters, withPathExtension: APIConstants.Methods.searchRecipes))
        
        request = networkController.createRequestWith(request: request, method: .get, and: nil)

        /* 4. Make the request */
        
        networkController.taskForGetMethod(request: request, completionHandlerForGET: { (result,error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGettingRecipes(nil, NSError(domain: "getRecipe", code: 1, userInfo: userInfo))
            }
            
            guard error == nil else {
                return sendError("getRecipe returns an error")
            }
            
            guard let resultsDictOfRecipes = result?[APIConstants.JSONBodyResponseKeys.Recipe.results] as? [[String:AnyObject]] else {
                return sendError("Could not find \(APIConstants.JSONBodyResponseKeys.Recipe.results) in \(result)")
            }
            
            let recipes = Recipe.arrayOfRecipes(from: resultsDictOfRecipes)
            
            completionHandlerForGettingRecipes(recipes, nil)
            
        })
        
    }

    
    func getRecipe(by id: String, completionHandlerForGettingRecipe: @escaping (Recipe?, NSError?) -> Void) {
     
        /* 1. Set the parameters */
        
        let parameters : [String:AnyObject] = [
            APIConstants.UrlKeys.id : id as AnyObject
        ]
        
        /* 2. Build the URL & Configure the request*/
        
        var request = NSMutableURLRequest(url: networkController.parseURLFromParameters(parameters, withPathExtension: addIdToMethod(APIConstants.Methods.searchRecipeInformation, with: id)))
        
        request = networkController.createRequestWith(request: request, method: .get, and: nil)

        /* 4. Make the request */
        
        networkController.taskForGetMethod(request: request, completionHandlerForGET: { (result,error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGettingRecipe(nil, NSError(domain: "getRecipe", code: 1, userInfo: userInfo))
            }
            
            guard error == nil else {
                return sendError("getRecipe returns an error")
            }
            
            guard let dictionaryResult = result as? [String:AnyObject] else {
                return sendError("There was no results from getRecipe query")
            }
            
            guard let ingredientsFromResult = result?[APIConstants.JSONBodyResponseKeys.Recipe.extendedIngredients] as? [[String:AnyObject]] else {
                return sendError("There was no results from getRecipe query")
            }
            
            let ingredients = Ingredient.arrayOfIngredients(from: ingredientsFromResult)
            var recipe = Recipe(dictionary: dictionaryResult)
            
            recipe.ingredients = ingredients
            
            completionHandlerForGettingRecipe(recipe, nil)
            
        })
        
    }
    
    func getComplexRecipes(completionHandlerForGettingRecipes completionHandlerForGettingComplexRecipe: @escaping ([Recipe]?, NSError?) -> Void) {
        
        /* 1. Set the parameters */
        let userProfile = UserProfile.shared
        let settings = Settings.shared
        
        let randomPage = Int(arc4random_uniform(900))
        
        guard let type = settings.type?.rawValue else{
            return
        }
        
        var parameters : [String:AnyObject] = [
            APIConstants.UrlKeys.ranking : settings.ranking.rawValue as AnyObject,
            APIConstants.UrlKeys.limitLicense : false as AnyObject,
            APIConstants.UrlKeys.number : 20 as AnyObject,
            APIConstants.UrlKeys.query : type as AnyObject,
            APIConstants.UrlKeys.offset : randomPage as AnyObject
        ]
        
        if let cuisine = settings.cuisine {
            parameters[APIConstants.UrlKeys.cuisine] = cuisine.rawValue as AnyObject
        }
        
        if let includeIngredients = userProfile.includeIngredients {
            let array : String = includeIngredients.map({$0.name!}).reduce(""){(text: String, name: String) -> String in
                return text + " \(name)"
            }
            parameters[APIConstants.UrlKeys.includeIngredients] = array as AnyObject
        }
        
        /* 2. Build the URL & Configure the request*/
        
        var request = NSMutableURLRequest(url: networkController.parseURLFromParameters(parameters, withPathExtension: APIConstants.Methods.searchComplexRecipe))
        
        request = networkController.createRequestWith(request: request, method: .get, and: nil)
        
        
        /* 4. Make the request */
        
        networkController.taskForGetMethod(request: request, completionHandlerForGET: { (result,error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGettingComplexRecipe(nil, NSError(domain: "getRecipe", code: 1, userInfo: userInfo))
            }
            
            guard error == nil else {
                return sendError("getRecipe returns an error")
            }
            
            guard let resultsDictOfRecipes = result?[APIConstants.JSONBodyResponseKeys.Recipe.results] as? [[String:AnyObject]] else {
                return sendError("Could not find \(APIConstants.JSONBodyResponseKeys.Recipe.results) in \(result)")
            }
            
            let recipes = Recipe.arrayOfRecipes(from: resultsDictOfRecipes)
            
            completionHandlerForGettingComplexRecipe(recipes, nil)
            
        })
    }
    
    func getIngredient(by query: String, completionHandlerForGettingIngredient: @escaping ([Ingredient]?, NSError?) -> Void) {
        
        /* 1. Set the parameters */
        
        let parameters : [String:AnyObject] = [
            APIConstants.UrlKeys.metaInformation : "true" as AnyObject,
            APIConstants.UrlKeys.number : 10 as AnyObject,
            APIConstants.UrlKeys.query : query as AnyObject
        ]
        
        /* 2. Build the URL & Configure the request*/
        
        var request = NSMutableURLRequest(url: networkController.parseURLFromParameters(parameters, withPathExtension: APIConstants.Methods.searchAutocompleteIngredients))
        
        request = networkController.createRequestWith(request: request, method: .get, and: nil)
        
        /* 4. Make the request */
        
        networkController.taskForGetMethod(request: request, completionHandlerForGET: { (result,error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGettingIngredient(nil, NSError(domain: "getIngredient", code: 1, userInfo: userInfo))
            }
            
            guard error == nil else {
                return sendError("getRecipe returns an error")
            }
            
            guard let dictionaryResult = result as? [[String:AnyObject]] else {
                return sendError("There was no results from getIngredient query")
            }
            
            let ingredients = Ingredient.arrayOfIngredients(from: dictionaryResult)
            
            completionHandlerForGettingIngredient(ingredients, nil)
            
        })
    }
    
    func getImage(by imageID: String, with size: ConstantsGeneral.ImageSize, completionHandlerForGettingImage: @escaping (UIImage?, NSError?) -> Void) {
        
        let imageURL = APIConstants.BasicConstants.hostRecipeImages + imageID + "-" + size.rawValue + ".jpg"
        let url = URL(string: imageURL)
        
        guard let data = try? Data(contentsOf: url!) else {
            let userInfo = [NSLocalizedDescriptionKey : "url is wrong for the image \(imageID)"]
            return completionHandlerForGettingImage(nil,NSError(domain: "getIngredient", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForGettingImage(UIImage(data: data),nil)

    }

}

private extension CookItAPI {

    func addIdToMethod(_ method: String, with id: String) -> String{
        return method.replacingOccurrences(of: "{id}", with: id)
    }
    
}
