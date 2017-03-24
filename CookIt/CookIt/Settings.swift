//
//  Settings.swift
//  CookIt
//
//  Created by Daniel Torres on 3/24/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation

struct Settings {
    
    static var shared = Settings()

    enum Ranking : Int {
        case maxUsedIngredients = 1, minMissingIngredients
    }
    
    var cuisine: ConstantsGeneral.Cuisine?
    var type: ConstantsGeneral.TypeDish?
    var ranking: Ranking
    
    init(cuisine: ConstantsGeneral.Cuisine, type: ConstantsGeneral.TypeDish, ranking: Ranking = .maxUsedIngredients){
        self.cuisine = cuisine
        self.type = type
        self.ranking = ranking
    }
    
    init(){
        ranking = Ranking.maxUsedIngredients
    }
    
    /*setting
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
