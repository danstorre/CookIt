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
    var imageString : String?
    var baseUri : String?
    
    // recipe information properties
    var vegetarian : Bool?
    var glutenFree : Bool?
    var cheap : Bool?
    var sustainable : Bool?
    var servings : Int?
    var instructions : String?
    
    // complex recipe information
    var calories : Int?
    var protein : String?
    var fat : String?
    var carbs : String?
    
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
        
        if let calories = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.calories] as? Int {
            self.calories = calories
        }
        
        if let protein = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.protein] as? String {
            self.protein = protein
        }
        
        if let fat = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.fat] as? String {
            self.fat = fat
        }
        
        if let carbs = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.carbs] as? String {
            self.carbs = carbs
        }
        
        if let instructions = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.instructions] as? String {
            self.instructions = instructions
        }
        
        if let imageString = dictionary[APIConstants.JSONBodyResponseKeys.Recipe.image] as? String {
            self.imageString = imageString
        }
        
    }
    
    static func arrayOfRecipes(from dictionary: [[String:AnyObject]]) -> [Recipe]{
        var recipesToReturn = [Recipe]()
        
        for recipe in dictionary{
            recipesToReturn.append(Recipe(dictionary: recipe))
        }
        
        return recipesToReturn
    }
    
    
    static func toRecipe(from dbRecipe: DBRecipe) -> Recipe{
        
        var recipe = Recipe()
        
        recipe.id = Int(dbRecipe.id)
        recipe.title = dbRecipe.title
        recipe.readyInMinutes = Int(dbRecipe.readyInMinutes)
        recipe.baseUri = dbRecipe.baseUri
        recipe.vegetarian = dbRecipe.vegetarian
        recipe.glutenFree = dbRecipe.glutenFree
        recipe.cheap = dbRecipe.cheap
        recipe.sustainable = dbRecipe.sustainable
        recipe.servings = Int(dbRecipe.servings)
        recipe.calories = Int(dbRecipe.calories)
        recipe.protein = dbRecipe.protein
        recipe.fat = dbRecipe.fat
        recipe.carbs = dbRecipe.carbs
        recipe.instructions = dbRecipe.instructions
        recipe.imageString = dbRecipe.imageString
        
        return recipe
    
    }
}
