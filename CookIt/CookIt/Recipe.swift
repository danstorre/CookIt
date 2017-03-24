//
//  Recipe.swift
//  CookIt
//
//  Created by Daniel Torres on 3/23/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation
import UIKit

struct Recipe {
    
    // list properties
    var id : Int?
    var title : String?
    var readyInMinutes : Int?
    var image : UIImage?
    var baseUri : String?
    
    // recipe information properties
    var vegetarian : Bool?
    var glutenFree : Bool?
    var cheap : Bool?
    var sustainable : Bool?
    var servings : Int?
    var instructions : String?
    
    var ingredients: [Ingredient]?
    
    //var extendedIngredients : Bool?
    
    init(id : Int, title : String, readyInMinutes : Int? = nil, image : UIImage? = nil, baseUri : String? = nil,
         ingredients: [Ingredient]? = nil){
        self.id = id
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.image = image
        self.baseUri = baseUri
    }
    
    init(){
        self.id = 0
        self.title = ""
        self.readyInMinutes = 0
    }
    
    init(dictionary: [String:AnyObject]){
        
        if let id = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.id] as? Int {
            self.id = id
        }
        
        if let title = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.title] as? String {
            self.title = title
        }

        if let readyInMinutes = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.readyInMinutes] as? Int {
            self.readyInMinutes = readyInMinutes
        }
        
        if let baseUri = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.baseUri] as? String {
            self.baseUri = baseUri
        }
        
        if let vegetarian = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.vegetarian] as? Bool {
            self.vegetarian = vegetarian
        }
        
        if let glutenFree = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.glutenFree] as? Bool {
            self.glutenFree = glutenFree
        }
        
        if let cheap = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.cheap] as? Bool {
            self.cheap = cheap
        }

        if let sustainable = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.sustainable] as? Bool {
            self.sustainable = sustainable
        }
        
        if let servings = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.servings] as? Int {
            self.servings = servings
        }
        
        if let instructions = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.instructions] as? String {
            self.instructions = instructions
        }
        
    }
    
    static func arrayOfRecipes(from dictionary: [[String:AnyObject]]) -> [Recipe]{
        var recipesToReturn = [Recipe]()
        
        for recipe in dictionary{
            recipesToReturn.append(Recipe(dictionary: recipe))
        }
        
        return recipesToReturn
    }
}
