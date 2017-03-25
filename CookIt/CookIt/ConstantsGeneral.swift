//
//  ConstantsGeneral.swift
//  CookIt
//
//  Created by Daniel Torres on 3/24/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import Foundation


struct ConstantsGeneral {
    
    
    enum Cuisine : String {
        case emptyString = ""
        case african, chinese, japanese, korean, vietnamese, thai, indian, british, irish, french, italian, mexican, spanish, jewish, american, cajun, southern, greek, german, nordic, caribbean
        case middleEastern = "middle eastern"
        case easternEuropean = "eastern european"
        case latinAmerican = "latin american"
        
    }
    
    enum Diet: String {
        case emptyString = ""
        case pescetarian, vegan, paleo, primal, vegetarian
        case lactoVegetarian = "lacto vegetarian"
        case ovoVegetarian = "ovo vegetarian"
    }
    
    enum Intolerances: String {
        case emptyString = ""
        case dairy, egg, gluten, peanut, sesame, seafood, shellfish, soy, sulfite, wheat
        case treeNut = "tree nut"
    }
    
    enum TypeDish: String {
        case emptyString = ""
        case dessert, appetizer, salad, bread, breakfast, soup, beverage, sauce, drink
        case mainCourse = "main course"
        case sideDish = "side dish"
    }
    
    enum ImageSize: String {
        case xxs = "90x90"
        case xs = "240x150"
        case s = "312x150"
        case m = "312x231"
        case l = "480x360"
        case xl = "556x370"
        case xxl = "636x393"
    }
    
    
}
