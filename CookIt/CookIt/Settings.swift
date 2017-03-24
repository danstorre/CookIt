//
//  Settings.swift
//  CookIt
//
//  Created by Daniel Torres on 3/24/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation

struct Settings {

    enum Ranking : Int {
        case maxUsedIngredients = 1, minMissingIngredients
    }
    
    var cuisine: String?
    var type: String?
    var ranking: Int?
    
    init(cuisine: String, type: String, ranking: Ranking = .maxUsedIngredients){
    
    
    }
    
    /*setting
      //selected by the user in navigation
      //selected by the user in navigation
     maxCalories
     maxCarbs
     maxFat
     maxProtein
     minCalories
     minCarbs
     minFat
     minProtein
     ranking //Whether to maximize used ingredients (1) or minimize missing ingredients (2) first.
     */
}
