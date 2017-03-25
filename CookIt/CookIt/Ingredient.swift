//
//  Ingredient.swift
//  CookIt
//
//  Created by Daniel Torres on 3/24/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation
import UIKit

struct Ingredient {
        
    var id: Int?
    var aisle: String? //the generic name of the ingredient
    var name: String?
    var amount: Int?
    var unit: String?
    var unitShort: String?
    var unitLong: String?
    var originalString: String? // whole description of ingredient
    var stringImage: String?
    var image: UIImage?
    
    init(name: String) {
        self.name = name
    }

    init(id: Int,
     aisle: String, //the generic name of the ingredient
     name: String,
     amount: Int,
     unit: String,
     unitShort: String,
     unitLong: String,
     originalString: String // whole description of ingredient
        ) {
        self.id = id
        self.aisle = aisle //the generic name of the ingredient
        self.name = name
        self.amount = amount
        self.unit = unit
        self.unitShort = unitShort
        self.unitLong = unitLong
        self.originalString = originalString // whole description of ingredient
    }
    
    init(dictionary: [String:AnyObject]){
    
        if let id = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.id] as? Int{
            self.id = id
        }
        
        if let aisle = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.aisle] as? String{
            self.aisle = aisle
        }

        if let name = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.name] as? String{
            self.name = name
        }
        
        if let amount = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.amount] as? Int{
            self.amount = amount
        }
        
        if let unit = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.unit] as? String{
            self.unit = unit
        }
        
        if let unitShort = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.unitShort] as? String{
            self.unitShort = unitShort
        }
        
        if let unitLong = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.unitLong] as? String{
            self.unitLong = unitLong
        }
        
        if let originalString = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.originalString] as? String{
            self.originalString = originalString
        }
        
        if let stringImage = dictionary[APIConstants.JSONBodyResponseKeys.Ingredient.image] as? String{
            self.stringImage = stringImage
        }
    }
    
    static func arrayOfIngredients(from dictionary: [[String:AnyObject]]) -> [Ingredient]{
        var ingredientsToReturn = [Ingredient]()
        
        for ingredient in dictionary{
            ingredientsToReturn.append(Ingredient(dictionary: ingredient))
        }
        
        return ingredientsToReturn
    }
    
}
