//
//  ConstantsLocation.swift
//  OntheMap_DanielTorres
//
//  Created by Daniel Torres on 12/18/16.
//  Copyright © 2016 Daniel Torres. All rights reserved.
//

import UIKit

struct APIConstants {

    // MARK: Constants
    struct BasicConstants {
        
        // MARK: URLs
        static let apiScheme = "https"
        static let apiHost = "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
        static let mashapeKey = Credentials.mashapeKey
        
    }
    
    // MARK: Methods
    struct Methods {
        
        static let searchRecipes = "/recipes/search"
        static let searchRecipeInformation = "/recipes/{id}/information"
        static let searchComplexRecipe = "/recipes/searchComplex"
        
    }
    
    struct UrlKeys {
        
        // Search Recipes
        static let cuisine = "cuisine"
        static let diet = "diet"
        static let intolerances = "intolerances"
        static let excludeIngredients = "excludeIngredients"
        static let number = "number"
        static let offset = "offset"
        static let query = "query"
        static let type = "type"
        
        // Search Recipe
        static let id = "id"
        static let nutrition = "nutrition"
        
        // Complex Recipe search
        static let includeIngredients = "includeIngredients"
        static let limitLicense = "limitLicense"
        static let maxCalories = "maxCalories"
        static let maxCarbs = "maxCarbs"
        static let maxFat = "maxFat"
        static let maxProtein = "maxProtein"
        static let minCalories = "minCalories"
        static let minCarbs = "minCarbs"
        static let minFat = "minFat"
        static let minProtein = "minProtein"
        static let ranking = "ranking"
        
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        
    }
    
    // MARK: JSON Body Response Keys
    struct JSONBodyResponseKeys {
     
        struct Recipe{
            //Search Recipes
            static let results = "results"
            static let id = "id"
            static let title = "title"
            static let readyInMinutes = "readyInMinutes"
            static let image = "image"
            static let baseUri = "baseUri"
            
            // Search Recipe
            static let vegetarian = "vegetarian"
            static let glutenFree = "glutenFree"
            static let cheap = "cheap"
            static let sustainable = "sustainable"
            static let servings = "servings"
            static let extendedIngredients = "extendedIngredients"
            static let instructions = "instructions"
        }
        
        // Ingredient
        struct Ingredient{
            static let id = "id"
            static let aisle = "aisle" //the generic name of the ingredient
            static let name = "name"
            static let amount = "amount"
            static let unit = "unit"
            static let unitShort = "unitShort"
            static let unitLong = "unitLong"
            static let originalString = "originalString" // whole description of ingredient
        }
        
        
    }
}
