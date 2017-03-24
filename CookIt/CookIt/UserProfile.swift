//
//  UserProfile.swift
//  CookIt
//
//  Created by Daniel Torres on 3/24/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation

struct UserProfile {
    
    static var shared : UserProfile = UserProfile()

    var excludeIngredients : [Ingredient]? 
    var includeIngredients : [Ingredient]?
    var intolerances: [String]?
    var diet: String?
    
    
    init() {
        
    }
    
    
}
