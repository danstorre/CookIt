//
//  ParseApiController.swift
//  OntheMap_DanielTorres
//
//  Created by Daniel Torres on 12/18/16.
//  Copyright © 2016 Daniel Torres. All rights reserved.
//

import UIKit


protocol CookItProtocol {
    
}


class CookItAPI: CookItProtocol {
    
    let networkController = Network()
    
    init(){
        networkController.headers = [
            "Accept": "application/json",
            "X-Mashape-Key": "DXhfvCtPYVmsh0xsHscEdng0eguRp1EuKZDjsn1U6Y919tt8O4"
        ]
        
        networkController.host = "spoonacular-recipe-food-nutrition-v1.p.mashape.com"
        networkController.scheme = "https"
    }
    
    
}
