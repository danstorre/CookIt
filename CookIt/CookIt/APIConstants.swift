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
        
        static let searchRecipe = "/recipes/search"
    
    }
    
    struct UrlKeys {
        
        // Search Recipes
        static let cuisine = "cuisine"
        static let diet = "diet"
        static let intolerances = "intolerances"
        static let number = "number"
        static let offset = "offset"
        static let query = "query"
        static let type = "type"
        
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        
        static let updateAt = "updateAt"
    
    }
    
    // MARK: JSON Body Response Keys
    struct JSONBodyResponseKeys {
        
        //List Student Locations
        static let results = "results"
        
        
    }
}
