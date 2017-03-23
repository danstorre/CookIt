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
    
}


class CookItAPI: CookItProtocol {
    
    
    let networkController = Network()
    
    init(){
        networkController.headers = [
            "Accept": "application/json",
            "X-Mashape-Key": "DXhfvCtPYVmsh0xsHscEdng0eguRp1EuKZDjsn1U6Y919tt8O4"
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
        
        var request = NSMutableURLRequest(url: networkController.parseURLFromParameters(parameters, withPathExtension: APIConstants.Methods.searchRecipe))
        
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
            
            guard let resultsDictOfRecipes = result?[APIConstants.JSONBodyResponseKeys.results] as? [[String:AnyObject]] else {
                return sendError("Could not find \(APIConstants.JSONBodyResponseKeys.results) in \(result)")
            }
            
            let recipes = Recipe.arrayOfRecipes(from: resultsDictOfRecipes)
            
            completionHandlerForGettingRecipes(recipes, nil)
            
        })
        
    }

    
}
