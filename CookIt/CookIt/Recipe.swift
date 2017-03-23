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
    
    var id : Int?
    var title : String?
    var readyInMinutes : Int?
    var image : UIImage?
    var baseUri : String?
    
    init(id : Int, title : String, readyInMinutes : Int? = nil, image : UIImage? = nil, baseUri : String? = nil){
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
        self.image = nil
        self.baseUri = nil
    }
    
    init(dictionary: [String:AnyObject]){
        
        if let id = dictionary[APIConstants.JSONBodyResponseKeys.id] as? Int {
            self.id = id
        }
        
        if let title = dictionary[APIConstants.JSONBodyResponseKeys.title] as? String {
            self.title = title
        }

        if let readyInMinutes = dictionary[APIConstants.JSONBodyResponseKeys.readyInMinutes] as? Int {
            self.readyInMinutes = readyInMinutes
        }
        
        self.image = UIImage()
        
        if let baseUri = dictionary[APIConstants.JSONBodyResponseKeys.baseUri] as? String {
            self.baseUri = baseUri
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
